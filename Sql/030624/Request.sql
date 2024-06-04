-- Insert from select etape

INSERT INTO Etape (NomEtape, Longueur, NbrCoureurEquipe, DateHeureDepart, Rang)  
SELECT nometape,  
CAST(longueur AS DECIMAL(18,2)),  
nbcoureur,  
dateheuredepart,    
rang  
FROM etapeTemp et  
WHERE NOT EXISTS ( 
SELECT 1  
FROM Etape e  
WHERE e.NomEtape = et.nometape  
AND e.Longueur = CAST(et.longueur AS DECIMAL(18,2))  
AND e.NbrCoureurEquipe = et.nbcoureur  
AND e.DateHeureDepart = et.dateheuredepart  
AND e.Rang = et.rang);



-- Insert from select resultat

-- WITH equipe_insert AS (
--     INSERT INTO Equipe (NomEquipe, mail, pwd)
--     SELECT DISTINCT equipe, '', '' -- mail et pwd sont laissés vides
--     FROM resultatcoursetemp
--     ON CONFLICT (NomEquipe) DO NOTHING -- Ignorer si l'équipe existe déjà
--     RETURNING idEquipe, NomEquipe
-- ),
-- coureur_insert AS (
--     INSERT INTO Coureur (NomCoureur, Numero, Genre, DateNaissance, idEquipe)
--     SELECT DISTINCT nom, numero_dossard, genre,date_naissance, e.idEquipe
--     FROM resultatcoursetemp r
--     JOIN equipe_insert e ON r.equipe = e.NomEquipe
--     ON CONFLICT (Numero) DO NOTHING -- Ignorer si le numéro de dossard existe déjà
--     RETURNING idCoureur, NomCoureur, Numero
-- ),
-- insert_coureur_etape AS (
--     INSERT INTO CoureurEtape (idEtape, idCoureur, DateHeureArrivee)
--     SELECT e.idEtape, c.idCoureur,arrivee
--     FROM resultatcoursetemp r
--     JOIN equipe_insert eq ON r.equipe = eq.NomEquipe
--     JOIN coureur_insert c ON r.numero_dossard = c.Numero
--     JOIN Etape e ON e.NomEtape = r.etape_rang
--     LEFT JOIN CoureurEtape ce ON e.idEtape = ce.idEtape AND c.idCoureur = ce.idCoureur
--     WHERE ce.idEtape IS NULL -- Vérifier si le coureur n'a pas déjà participé à cette étape
-- )
-- SELECT * FROM insert_coureur_etape;


-- insert from select 

WITH equipe_insert AS (
    INSERT INTO Equipe (NomEquipe, mail, pwd)
    SELECT DISTINCT nomequipe, 
           nomequipe || '@gmail.com' AS mail,
           nomequipe || 'pass' AS pwd
    FROM resultatcoursetemp
    ON CONFLICT (NomEquipe) DO NOTHING
    RETURNING idEquipe, NomEquipe
),
equipe_select AS (
    SELECT idEquipe, NomEquipe
    FROM Equipe
    WHERE NomEquipe IN (SELECT DISTINCT nomequipe FROM resultatcoursetemp)
),
coureur_insert AS (
    INSERT INTO Coureur (NomCoureur, Numero, Genre, DateNaissance, idEquipe)
    SELECT DISTINCT nomcoureur, numcoureur, genrecoureur, datenaissancecoureur, e.idEquipe
    FROM resultatcoursetemp r
    JOIN equipe_insert e ON r.nomequipe = e.NomEquipe
    ON CONFLICT (Numero) DO NOTHING
    RETURNING idCoureur, NomCoureur, Numero
),
coureur_select AS (
    SELECT idCoureur, Numero
    FROM Coureur
    WHERE Numero IN (SELECT DISTINCT numcoureur FROM resultatcoursetemp)
),
insert_coureur_etape AS (
    INSERT INTO CoureurEtape (idEtape, idCoureur, DateHeureArrivee)
    SELECT e.idEtape, c.idCoureur, r.dateheurearrivee
    FROM resultatcoursetemp r
    JOIN (SELECT idEquipe, NomEquipe FROM equipe_insert
          UNION ALL
          SELECT idEquipe, NomEquipe FROM equipe_select) eq ON r.nomequipe = eq.NomEquipe
    JOIN (SELECT idCoureur, Numero FROM coureur_insert
          UNION ALL
          SELECT idCoureur, Numero FROM coureur_select) c ON r.numcoureur = c.Numero
    JOIN Etape e ON e.rang = r.rangetape
    LEFT JOIN CoureurEtape ce ON e.idEtape = ce.idEtape AND c.idCoureur = ce.idCoureur
    WHERE ce.idEtape IS NULL
    RETURNING idEtape, idCoureur, DateHeureArrivee
)
SELECT * FROM insert_coureur_etape;



-- fonction attribution categorie

CREATE OR REPLACE FUNCTION insert_categorie_coureur()
RETURNS void AS $$
DECLARE
    coureur RECORD;
    id_homme INTEGER;
    id_femme INTEGER;
    id_junior INTEGER;
BEGIN
    -- Récupérer les IDs des catégories
    SELECT idCategorie INTO id_homme FROM Categorie WHERE NomCategorie = 'Homme';
    SELECT idCategorie INTO id_femme FROM Categorie WHERE NomCategorie = 'Femme';
    SELECT idCategorie INTO id_junior FROM Categorie WHERE NomCategorie = 'Junior';

    -- Boucle sur tous les coureurs
    FOR coureur IN SELECT idCoureur, Genre, DateNaissance FROM Coureur LOOP
        -- Insérer dans CategorieCoureur pour la catégorie "Homme" ou "Femme"
        IF coureur.Genre = 'M' THEN
            INSERT INTO CategorieCoureur (idCoureur, idCategorie)
            VALUES (coureur.idCoureur, id_homme)
            ON CONFLICT (idCoureur, idCategorie) DO NOTHING;
        ELSIF coureur.Genre = 'F' THEN
            INSERT INTO CategorieCoureur (idCoureur, idCategorie)
            VALUES (coureur.idCoureur, id_femme)
            ON CONFLICT (idCoureur, idCategorie) DO NOTHING;
        END IF;

        -- Insérer dans CategorieCoureur pour la catégorie "Junior"
        IF age(coureur.DateNaissance) < INTERVAL '18 years' THEN
            INSERT INTO CategorieCoureur (idCoureur, idCategorie)
            VALUES (coureur.idCoureur, id_junior)
            ON CONFLICT (idCoureur, idCategorie) DO NOTHING;
        END IF;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


