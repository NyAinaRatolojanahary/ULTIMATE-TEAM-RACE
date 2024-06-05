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
DENSE_RANK() OVER (PARTITION BY ce.idEtape ORDER BY ((ce.DateHeureArrivee - e.DateHeureDepart) + COALESCE(pe.TempsPenalite,'00:00:00')) ASC) AS Classement,
c.Genre,
(ce.DateHeureArrivee - e.DateHeureDepart) as chrono
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
pe.TempsPenalite,
c.Genre;


-- maka nombre coureur autorise @ etape
CREATE OR REPLACE view v_nbrCoureurAutoriseEtape as
SELECT e.idEtape,nbrcoureurequipe
FROM Etape e ;

--vue maka nombre coureur mbola afaka miditra

CREATE OR REPLACE view v_nbrCoureurAssignerEtape AS
SELECT ce.idEtape,c.idEquipe,COUNT(ce.idCoureur)
FROM CoureurEtape ce
JOIN Coureur c ON c.idCoureur = ce.idCoureur
JOIN Etape et ON et.idEtape = ce.idEtape
JOIN Equipe eq ON eq.idEquipe = c.idEquipe
GROUP BY ce.idEtape,c.idEquipe;

--  vue maka ny equipe sisa tsy anaty etape

/*SELECT c.idCoureur,c.NomCoureur,ce.idEtape,eq.idEquipe
FROM Coureur c
JOIN Equipe eq on eq.idEquipe = c.idEquipe
LEFT JOIN CoureurEtape ce on ce.idCoureur = c.idCoureur
JOIN Etape et on et.idEtape = ce.idEtape
WHERE ce.idEtape = 30 AND eq.idEquipe = 170
GROUP BY c.idCoureur,c.NomCoureur,ce.idEtape,eq.idEquipe;

SELECT ce.idEtape,et.nometape,c.idCoureur,c.nomCoureur,c.idEquipe
FROM CoureurEtape ce 
LEFT JOIN Coureur c ON c.idCoureur = ce.idCoureur
JOIN Etape et ON et.idEtape = ce.idEtape
JOIN Equipe eq ON eq.idEquipe = c.idEquipe
WHERE ce.idEtape = 30 AND eq.idEquipe=170;*/
CREATE OR REPLACE view v_CoureurNonAffecterEtape AS
SELECT
    e.idEtape,
    c.idCoureur,
    c.NomCoureur,
    c.Numero,
    c.Genre,
    c.DateNaissance,
    c.idEquipe
FROM
    Etape e
    CROSS JOIN Coureur c
    LEFT JOIN CoureurEtape ce ON e.idEtape = ce.idEtape AND c.idCoureur = ce.idCoureur
WHERE
    ce.idCoureur IS NULL;




 select * from coureuretape ce join coureur c on c.idCoureur = ce.idCoureur join equipe eq on eq.idEquipe = c.idEquipe ORDER BY ce.idEtape;