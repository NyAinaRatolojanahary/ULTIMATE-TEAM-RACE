-- Vue qui select tous les coureurs d'un etape dont la DateHeureArrivee n'est pas encore posee

CREATE OR REPLACE view v_CoureurEtapeNonArrivee as
SELECT ce.idEtape,e.NomEtape,c.idCoureur,c.NomCoureur,c.Numero
FROM CoureurEtape ce
JOIN Coureur c on c.idCoureur = ce.idCoureur
JOIN Etape e on e.idEtape = ce.idEtape
WHERE ce.DateHeureArrivee IS NULL;


-- Vue Temps Passer Par Coureur par Etape

CREATE OR REPLACE view v_TempsPasseCoureurEtape as
SELECT ce.idEtape,e.NomEtape,eq.idEquipe,eq.NomEquipe,ce.idCoureur,c.NomCoureur,e.DateHeureDepart,ce.DateHeureArrivee,
(ce.DateHeureArrivee-e.DateHeureDepart) AS DIFF,
EXTRACT(EPOCH FROM (ce.DateHeureArrivee-e.DateHeureDepart)) / 3600 AS hour_diff,
EXTRACT(EPOCH FROM (ce.DateHeureArrivee-e.DateHeureDepart)) / 86400 AS day_diff
FROM CoureurEtape ce
JOIN Coureur c on c.idCoureur = ce.idCoureur
JOIN Equipe eq on eq.idEquipe = c.idEquipe
JOIN Etape e on e.idEtape = ce.idEtape
GROUP BY ce.idEtape,e.NomEtape,eq.idEquipe,eq.NomEquipe,ce.idCoureur,c.NomCoureur,e.DateHeureDepart,ce.DateHeureArrivee
ORDER BY ce.idEtape,(ce.DateHeureArrivee-e.DateHeureDepart) ASC;


-- SELECT ce.idEtape,e.NomEtape,eq.idEquipe,eq.NomEquipe,ce.idCoureur,c.NomCoureur,e.DateHeureDepart,ce.DateHeureArrivee,
-- (ce.DateHeureArrivee-e.DateHeureDepart) AS DIFF,
-- EXTRACT(EPOCH FROM (ce.DateHeureArrivee-e.DateHeureDepart)) / 60 AS min_diff,
-- EXTRACT(EPOCH FROM (ce.DateHeureArrivee-e.DateHeureDepart)) / 3600 AS hour_diff,
-- EXTRACT(EPOCH FROM (ce.DateHeureArrivee-e.DateHeureDepart)) / 86400 AS day_diff
-- FROM CoureurEtape ce
-- JOIN Coureur c on c.idCoureur = ce.idCoureur
-- JOIN Equipe eq on eq.idEquipe = c.idEquipe
-- JOIN Etape e on e.idEtape = ce.idEtape
-- GROUP BY ce.idEtape,e.NomEtape,eq.idEquipe,eq.NomEquipe,ce.idCoureur,c.NomCoureur,e.DateHeureDepart,ce.DateHeureArrivee
-- ORDER BY ce.idEtape,(ce.DateHeureArrivee-e.DateHeureDepart) ASC;

-- Vue Attribution Point par Coureur par etape

CREATE OR REPLACE VIEW v_CoureurEtapeClassement AS
SELECT 
ce.idEtape,
e.NomEtape,
eq.idEquipe,
eq.NomEquipe,
ce.idCoureur,
c.NomCoureur,
e.DateHeureDepart,
ce.DateHeureArrivee,
(ce.DateHeureArrivee - e.DateHeureDepart) AS DIFF,
EXTRACT(EPOCH FROM (ce.DateHeureArrivee - e.DateHeureDepart)) / 3600 AS hour_diff,
EXTRACT(EPOCH FROM (ce.DateHeureArrivee - e.DateHeureDepart)) / 86400 AS day_diff,
DENSE_RANK() OVER (PARTITION BY ce.idEtape ORDER BY ce.DateHeureArrivee - e.DateHeureDepart ASC) AS Classement
FROM CoureurEtape ce
JOIN Coureur c ON c.idCoureur = ce.idCoureur
JOIN Equipe eq ON eq.idEquipe = c.idEquipe
JOIN Etape e ON e.idEtape = ce.idEtape
GROUP BY 
ce.idEtape, e.NomEtape, eq.idEquipe, eq.NomEquipe, ce.idCoureur, c.NomCoureur, e.DateHeureDepart, ce.DateHeureArrivee
ORDER BY 
ce.idEtape, (ce.DateHeureArrivee - e.DateHeureDepart) ASC;


-- Vue Rang et Point Coureur par etape

-- CREATE OR REPLACE VIEW v_CoureurRang AS
-- SELECT 
-- vc.idEtape,
-- vc.NomEtape,
-- vc.idEquipe,
-- vc.NomEquipe,
-- vc.idCoureur,
-- vc.NomCoureur,
-- vc.DateHeureDepart,
-- vc.DateHeureArrivee,
-- vc.DIFF,
-- vc.hour_diff,
-- vc.day_diff,
-- vc.Classement,
-- r.Points
-- FROM v_CoureurEtapeClassement vc
-- JOIN PointRang r ON vc.Classement = r.Classement
-- ORDER BY vc.idEtape, vc.Classement ASC;

CREATE OR REPLACE VIEW v_CoureurRang AS
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
FROM v_CoureurEtapeClassement vc
LEFT JOIN PointRang r ON vc.Classement = r.Classement
ORDER BY vc.idEtape, vc.Classement ASC;


-- vue classement individuel par somme point coureur
CREATE OR REPLACE view v_ClassementIndividuel as
SELECT 
v_coureurrang.idCoureur,
v_coureurrang.nomCoureur,
c.Numero,
e.NomEquipe,
DENSE_RANK() OVER (ORDER BY sum(points) DESC) AS Rang,
sum(points) as points 
FROM v_coureurrang 
JOIN Coureur c on c.idCoureur = v_coureurrang.idCoureur
JOIN Equipe e on e.idEquipe = c.idEquipe
GROUP BY v_CoureurRang.idCoureur,v_coureurrang.NomCoureur,c.Numero,e.NomEquipe; 

-- vue somme point coureur par equipe

CREATE OR REPLACE view v_ClassementEquipe as
SELECT 
e.idEquipe,
e.NomEquipe,
sum(vci.points) as points,
DENSE_RANK() OVER (ORDER BY sum(vci.points) DESC) AS Rang
FROM v_ClassementIndividuel vci
JOIN Coureur c on c.idCoureur = vci.idCoureur
JOIN Equipe e on e.idEquipe = c.idEquipe
GROUP BY e.idEquipe,e.NomEquipe;




