-- vue listant les penalites des equipes

CREATE OR REPLACE VIEW v_PenaliteEquipe AS
SELECT et.idEtape,et.NomEtape,e.idEquipe,e.NomEquipe,pe.TempsPenalite
FROM PenaliteEquipe pe
JOIN Equipe e ON e.idEquipe = pe.idEquipe
JOIN Etape et ON et.idEtape = pe.idEtape;


-- vue Attribution coureur par etape en tenant compte des penalites
CREATE OR REPLACE view v_CoureurEtapeClassementPenalite AS
SELECT
ce.idEtape,
e.NomEtape,
eq.idEquipe,
eq.NomEquipe,
ce.idCoureur,
c.NomCoureur,
e.DateHeureDepart,
ce.DateHeureArrivee,
COALESCE(pe.TempsPenalite,'00:00:00') penalite,
((ce.DateHeureArrivee - e.DateHeureDepart) + COALESCE(pe.TempsPenalite,'00:00:00')) AS DIFF,
EXTRACT(EPOCH FROM ((ce.DateHeureArrivee - e.DateHeureDepart)+ COALESCE(pe.TempsPenalite,'00:00:00'))) / 3600 AS hour_diff,
EXTRACT(EPOCH FROM ((ce.DateHeureArrivee - e.DateHeureDepart)+ COALESCE(pe.TempsPenalite,'00:00:00'))) / 86400 AS day_diff,
DENSE_RANK() OVER (PARTITION BY ce.idEtape ORDER BY ((ce.DateHeureArrivee - e.DateHeureDepart) + COALESCE(pe.TempsPenalite,'00:00:00')) ASC) AS Classement
FROM CoureurEtape ce
JOIN Coureur c ON c.idCoureur = ce.idCoureur
JOIN Equipe eq ON eq.idEquipe = c.idEquipe
JOIN Etape e ON e.idEtape = ce.idEtape
LEFT JOIN PenaliteEquipe pe ON pe.idEquipe = eq.idEquipe AND pe.idEtape = e.idEtape
GROUP BY 
ce.idEtape,
e.NomEtape,
eq.idEquipe,
eq.NomEquipe,
ce.idCoureur,
c.NomCoureur,
e.DateHeureDepart,
ce.DateHeureArrivee,
pe.TempsPenalite;

-- Vue Rang et Point Coureur par etape avec Penalite

CREATE OR REPLACE VIEW v_CoureurRangPenalite AS
SELECT 
vc.idEtape,
vc.NomEtape,
vc.idEquipe,
vc.NomEquipe,
vc.idCoureur,
vc.NomCoureur,
vc.DateHeureDepart,
vc.DateHeureArrivee,
vc.DIFF,
vc.hour_diff,
vc.day_diff,
vc.Classement,
CASE
    WHEN r.Points IS NOT NULL THEN r.Points
    ELSE 0
END AS Points
FROM v_CoureurEtapeClassementPenalite vc
LEFT JOIN PointRang r ON vc.Classement = r.Classement
ORDER BY vc.idEtape, vc.Classement ASC;

-- vue classement individuel par somme point coureur avec penalite
CREATE OR REPLACE view v_ClassementIndividuelPenalite as
SELECT 
v_coureurrangpenalite.idCoureur,
v_coureurrangpenalite.nomCoureur,
c.Numero,
e.NomEquipe,
DENSE_RANK() OVER (ORDER BY sum(points) DESC) AS Rang,
sum(points) as points 
FROM v_coureurrangpenalite 
JOIN Coureur c on c.idCoureur = v_coureurrangpenalite.idCoureur
JOIN Equipe e on e.idEquipe = c.idEquipe
GROUP BY v_CoureurRangPenalite.idCoureur,v_coureurrangpenalite.NomCoureur,c.Numero,e.NomEquipe; 


-- VUE somme point coureur par equipe avec penalite

CREATE OR REPLACE view v_ClassementEquipe as
SELECT 
e.idEquipe,
e.NomEquipe,
sum(vci.points) as points,
DENSE_RANK() OVER (ORDER BY sum(vci.points) DESC) AS Rang
FROM v_ClassementIndividuelPenalite vci
JOIN Coureur c on c.idCoureur = vci.idCoureur
JOIN Equipe e on e.idEquipe = c.idEquipe
GROUP BY e.idEquipe,e.NomEquipe;

-- vue classement par categorie avec penalite

CREATE OR REPLACE VIEW v_ClassementCategoriePenalite AS
SELECT
    c.idCoureur,
    c.NomCoureur,
    cat.idCategorie,
    cat.NomCategorie,
    SUM(pr.Points) AS TotalPoints,
    DENSE_RANK() OVER (PARTITION BY cat.idCategorie ORDER BY SUM(pr.Points) DESC) AS ClassementFinal
FROM
    (
        SELECT
            ce.idEtape,
            cc.idCategorie,
            ce.idCoureur,
            EXTRACT(EPOCH FROM (
                ce.DateHeureArrivee + COALESCE(pe.TempsPenalite::interval, '00:00:00'::interval) - 
                MIN(ce.DateHeureArrivee + COALESCE(pe.TempsPenalite::interval, '00:00:00'::interval)) OVER (PARTITION BY ce.idEtape, cc.idCategorie)
            )) AS DiffTemps,
            DENSE_RANK() OVER (PARTITION BY ce.idEtape, cc.idCategorie ORDER BY ce.DateHeureArrivee + COALESCE(pe.TempsPenalite::interval, '00:00:00'::interval)) AS Classement
        FROM
            CoureurEtape ce
        JOIN
            CategorieCoureur cc ON ce.idCoureur = cc.idCoureur
        LEFT JOIN
            PenaliteEquipe pe ON ce.idEtape = pe.idEtape AND ce.idCoureur IN (SELECT idCoureur FROM Coureur WHERE idEquipe = pe.idEquipe)
    ) dtc
JOIN
    PointRang pr ON dtc.Classement = pr.Classement
JOIN
    Coureur c ON dtc.idCoureur = c.idCoureur
JOIN
    Categorie cat ON dtc.idCategorie = cat.idCategorie
GROUP BY
    c.idCoureur, c.NomCoureur, cat.idCategorie, cat.NomCategorie;



-- Vue classement general equipe par categorie

CREATE OR REPLACE VIEW v_ClassementGeneralEquipeCategoriePenalite AS
SELECT
    eq.NomEquipe,
    cat.idCategorie,
    cat.NomCategorie,
    SUM(pr.Points) AS TotalPoints,
    DENSE_RANK() OVER (PARTITION BY cat.idCategorie ORDER BY SUM(pr.Points) DESC) AS ClassementEquipe
FROM (
    SELECT
        ce.idEtape,
        cc.idCategorie,
        ce.idCoureur,
        EXTRACT(EPOCH FROM (
            ce.DateHeureArrivee + COALESCE(pe.TempsPenalite::interval, '00:00:00'::interval) - 
            MIN(ce.DateHeureArrivee + COALESCE(pe.TempsPenalite::interval, '00:00:00'::interval)) OVER (PARTITION BY ce.idEtape, cc.idCategorie)
        )) AS DiffTemps,
        DENSE_RANK() OVER (PARTITION BY ce.idEtape, cc.idCategorie ORDER BY ce.DateHeureArrivee + COALESCE(pe.TempsPenalite::interval, '00:00:00'::interval)) AS Classement
    FROM
        CoureurEtape ce
    JOIN
        CategorieCoureur cc ON ce.idCoureur = cc.idCoureur
    LEFT JOIN
        PenaliteEquipe pe ON ce.idEtape = pe.idEtape AND ce.idCoureur IN (SELECT idCoureur FROM Coureur WHERE idEquipe = pe.idEquipe)
) sub
JOIN
    PointRang pr ON sub.Classement = pr.Classement
JOIN
    Coureur c ON sub.idCoureur = c.idCoureur
JOIN
    Equipe eq ON c.idEquipe = eq.idEquipe
JOIN
    Categorie cat ON sub.idCategorie = cat.idCategorie
GROUP BY
    eq.NomEquipe, cat.idCategorie, cat.NomCategorie;


