CREATE OR REPLACE FUNCTION resetdatabase()
RETURNS void AS $$
BEGIN
   DELETE FROM PenaliteEquipe;
   DELETE FROM PointRang;
   DELETE FROM CoureurEtape;
   DELETE FROM CategorieCoureur;
   DELETE FROM Coureur;
   DELETE FROM Equipe;
   DELETE FROM Etape;
END;
$$ LANGUAGE plpgsql;