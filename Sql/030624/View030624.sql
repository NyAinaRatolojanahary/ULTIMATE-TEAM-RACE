-- vue qui prend les etapes dans laquelle une equipe a un ou plusieurs coureur

CREATE OR REPLACE view v_EtapeEquipe AS
SELECT e.NomEtape,e.longueur,e.NbrCoureurEquipe,ce.idEtape,c.idEquipe
FROM CoureurEtape ce 
JOIN Etape e ON e.idEtape = ce.idEtape
JOIN Coureur c ON c.idCoureur = ce.idCoureur
GROUP BY e.NomEtape,e.longueur,e.NbrCoureurEquipe,ce.idEtape,c.idEquipe;


-- vue classement par categorie ##############

{/*
-- Vue pour calculer la différence de temps de chaque coureur dans sa catégorie pour chaque étape
CREATE VIEW diff_temps_par_categorie AS
SELECT
    ce.idEtape,
    cc.idCategorie,
    ce.idCoureur,
    c.NomCoureur,
    et.NomEtape,
    ce.DateHeureArrivee,
    MIN(ce.DateHeureArrivee) OVER (PARTITION BY ce.idEtape, cc.idCategorie) AS DateHeureDepartCategorie,
    EXTRACT(EPOCH FROM (ce.DateHeureArrivee - MIN(ce.DateHeureArrivee) OVER (PARTITION BY ce.idEtape, cc.idCategorie))) AS DiffTemps,
    DENSE_RANK() OVER (PARTITION BY ce.idEtape, cc.idCategorie ORDER BY ce.DateHeureArrivee) AS Classement
FROM CoureurEtape ce
JOIN CategorieCoureur cc ON ce.idCoureur = cc.idCoureur
JOIN Coureur c  ON c.idCoureur = ce.idCoureur
JOIN Etape et ON et.idEtape = ce.idEtape;

-- Vue pour attribuer des points basés sur les classements
CREATE VIEW points_par_coureur AS
SELECT
    dtc.idEtape,
    dtc.idCategorie,
    dtc.idCoureur,
    dtc.Classement,
    pr.Points
FROM
    diff_temps_par_categorie dtc
JOIN
    PointRang pr ON dtc.Classement = pr.Classement;


-- Vue pour sommer les points par catégorie et attribuer des classements finaux
CREATE VIEW classement_final_par_categorie AS
SELECT
    ppc.idCategorie,
    ppc.idCoureur,
    SUM(ppc.Points) AS TotalPoints,
    DENSE_RANK() OVER (PARTITION BY ppc.idCategorie ORDER BY SUM(ppc.Points) DESC) AS ClassementFinal
FROM
    points_par_coureur ppc
GROUP BY
    ppc.idCategorie, ppc.idCoureur;


-- Vue globale pour afficher les résultats finaux
CREATE VIEW resultat_final AS
SELECT
    c.NomCoureur,
    cat.NomCategorie,
    cf.TotalPoints,
    cf.ClassementFinal
FROM
    classement_final_par_categorie cf
JOIN
    Coureur c ON cf.idCoureur = c.idCoureur
JOIN
    Categorie cat ON cf.idCategorie = cat.idCategorie;
*/}

CREATE OR REPLACE VIEW v_ClassementCategorie AS
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
            EXTRACT(EPOCH FROM (ce.DateHeureArrivee - MIN(ce.DateHeureArrivee) OVER (PARTITION BY ce.idEtape, cc.idCategorie))) AS DiffTemps,
            DENSE_RANK() OVER (PARTITION BY ce.idEtape, cc.idCategorie ORDER BY ce.DateHeureArrivee) AS Classement
        FROM
            CoureurEtape ce
        JOIN
            CategorieCoureur cc ON ce.idCoureur = cc.idCoureur
    ) dtc
JOIN
    PointRang pr ON dtc.Classement = pr.Classement
JOIN
    Coureur c ON dtc.idCoureur = c.idCoureur
JOIN
    Categorie cat ON dtc.idCategorie = cat.idCategorie
GROUP BY
    c.idCoureur,c.NomCoureur, cat.NomCategorie, cat.idCategorie,cat.NomCategorie;


-- Vue classement general equipe par categorie

CREATE OR REPLACE VIEW v_ClassementGeneralEquipeCategorie AS
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
        EXTRACT(EPOCH FROM (ce.DateHeureArrivee - MIN(ce.DateHeureArrivee) OVER (PARTITION BY ce.idEtape, cc.idCategorie))) AS DiffTemps,
        DENSE_RANK() OVER (PARTITION BY ce.idEtape, cc.idCategorie ORDER BY ce.DateHeureArrivee) AS Classement
    FROM
        CoureurEtape ce
    JOIN
        CategorieCoureur cc ON ce.idCoureur = cc.idCoureur
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
    eq.NomEquipe,cat.idCategorie, cat.NomCategorie, cat.idCategorie;




