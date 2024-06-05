/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Csv;


import Models.EtapeCourse;
import Models.Points;
import Models.ResultatCourse;
import Utils.ConnectBase;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.swing.text.DateFormatter;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;

/**
 *
 * @author Ny Aina Ratolo
 */
public class CsvUtilities {
    
    public List<CSVRecord> getCsvData(InputStream fichier,char sep) throws Exception{
        
        CSVFormat separateur = CSVFormat.DEFAULT.withHeader().withQuote('"').withDelimiter(sep);
        
        List<CSVRecord> record;
        
        try(CSVParser parser = new CSVParser(new InputStreamReader(fichier, "UTF8"),separateur);) {
            record = parser.getRecords();
        } catch (Exception e) {
            throw e;
        }
        
        return record;
        
    }
    
    public ArrayList<EtapeCourse> listeEtapeCourse(List<CSVRecord> lists){
        ArrayList<EtapeCourse> listes = new ArrayList<>();
        
        for (int i = 0; i < lists.size(); i++) {
            EtapeCourse ec = new EtapeCourse();
            ec.setNometape(lists.get(i).get("etape"));
            ec.setLongueur(ec.convertDouble(lists.get(i).get("longueur")));
            ec.setNbrcoureurequipe(Integer.parseInt(lists.get(i).get("nb coureur")));
            ec.setRang(Integer.parseInt(lists.get(i).get("rang")));
            String date = ec.convertDate(lists.get(i).get("date départ"));
            ec.setDateheuredepart(ec.composeDateHeureDepart(date, lists.get(i).get("heure départ")));
            listes.add(ec);
        }
        
        return listes;
    }
    
    public ArrayList<ResultatCourse> listeResultatCourse(List<CSVRecord> lists){
        ArrayList<ResultatCourse> listes = new ArrayList<>();
        
        for (int i = 0; i < lists.size(); i++) {
            ResultatCourse rc = new ResultatCourse();
            rc.setRangEtape(Integer.parseInt(lists.get(i).get("etape_rang")));
            rc.setNumCoureur(Integer.parseInt(lists.get(i).get("numero dossard")));
            rc.setNomCoureur(lists.get(i).get("nom").trim());
            rc.setGenreCoureur(lists.get(i).get("genre").charAt(0));
            String dtn = rc.convertDate(lists.get(i).get("date naissance"));
            rc.setDateNaissanceCoureur(dtn);
            rc.setNomEquipe(lists.get(i).get("equipe").trim());
            Timestamp arrivee = rc.convertStringToTimestamp(lists.get(i).get("arrivée"));
            rc.setDateHeureArrivee(arrivee);
            listes.add(rc);
        }
        
        return listes;
    }
    
    public ArrayList<Points> listePoint(List<CSVRecord> lists){
        ArrayList<Points> listes = new ArrayList<>();
        
        for (int i = 0; i < lists.size(); i++) {
            Points ec = new Points();
            ec.setClassement(Integer.parseInt(lists.get(i).get("classement")));
            ec.setPoint(Integer.parseInt(lists.get(i).get("points")));
            listes.add(ec);
        }
        
        return listes;
    }
    
    public void insertEtape(Connection c,ArrayList<EtapeCourse> lists)throws SQLException{
        Statement st = null;
        try {
            st = c.createStatement();
            st.executeUpdate("create temp table etapeTemp(numligne serial,nometape varchar(255),longueur varchar(255),nbcoureur decimal(18,2),rang int,dateheuredepart TIMESTAMP);");
            
            
            for (int i = 0; i < lists.size(); i++) {
                st.executeUpdate("insert into etapeTemp values (default,'"+lists.get(i).getNometape()+"',"+lists.get(i).getLongueur()+","+lists.get(i).getNbrcoureurequipe()+","+lists.get(i).getRang()+",'"+lists.get(i).getDateheuredepart()+"');");
            }
            
            st.executeUpdate("INSERT INTO Etape (NomEtape, Longueur, NbrCoureurEquipe, DateHeureDepart, Rang) " +
                 "SELECT nometape, " +
                 "CAST(longueur AS DECIMAL(18,2)), " +
                 "nbcoureur, " +
                 "dateheuredepart, " +  
                 "rang " +
                 "FROM etapeTemp et " +
                 "WHERE NOT EXISTS (" +
                 "SELECT 1 " +
                 "FROM Etape e " +
                 "WHERE e.NomEtape = et.nometape " +
                 "AND e.Longueur = CAST(et.longueur AS DECIMAL(18,2)) " +
                 "AND e.NbrCoureurEquipe = et.nbcoureur " +
                 "AND e.DateHeureDepart = et.dateheuredepart " +
                 "AND e.Rang = et.rang);");
            
        } catch (Exception e) {
            throw e;
        }
        finally{
            st.close();
        }
    }
    
    public void insertResultat(Connection c,ArrayList<ResultatCourse> lists)throws Exception{
        Statement st = null;
        ArrayList<HashMap> erreur = new ArrayList<HashMap>();
        try {
            st = c.createStatement();
            st.executeUpdate("CREATE temp TABLE resultatcoursetemp(numligne serial,rangEtape INT,numCoureur INT,nomCoureur VARCHAR(255),genreCoureur CHAR(1),dateNaissanceCoureur DATE,nomEquipe VARCHAR(255),dateHeureArrivee TIMESTAMP);");
            
            for (int i = 0; i < lists.size(); i++) {
                st.executeUpdate("INSERT INTO resultatcoursetemp (rangEtape, numCoureur, nomCoureur, genreCoureur, dateNaissanceCoureur, nomEquipe, dateHeureArrivee) VALUES ("+ lists.get(i).getRangEtape() +","+ lists.get(i).getNumCoureur()+",'"+ lists.get(i).getNomCoureur()+"','"+lists.get(i).getGenreCoureur()+"','"+ lists.get(i).getDateNaissanceCoureur() +"','"+lists.get(i).getNomEquipe()+"','"+lists.get(i).getDateHeureArrivee()+"');");
            }
            
            st.executeQuery("WITH equipe_insert AS (\n" +
                "    INSERT INTO Equipe (NomEquipe, mail, pwd)\n" +
                "    SELECT DISTINCT nomequipe, nomequipe||'@gmail.com' AS mail, nomequipe||'pass' AS pwd\n" +
                "    FROM resultatcoursetemp\n" +
                "    ON CONFLICT (NomEquipe) DO NOTHING\n" +
                "    RETURNING idEquipe, NomEquipe\n" +
                "),\n" +
                "equipe_select AS (\n" +
                "    SELECT idEquipe, NomEquipe\n" +
                "    FROM Equipe\n" +
                "    WHERE NomEquipe IN (SELECT DISTINCT nomequipe FROM resultatcoursetemp)\n" +
                "),\n" +
                "coureur_insert AS (\n" +
                "    INSERT INTO Coureur (NomCoureur, Numero, Genre, DateNaissance, idEquipe)\n" +
                "    SELECT DISTINCT nomcoureur, numcoureur, genrecoureur, datenaissancecoureur, e.idEquipe\n" +
                "    FROM resultatcoursetemp r\n" +
                "    JOIN equipe_insert e ON r.nomequipe = e.NomEquipe\n" +
                "    ON CONFLICT (Numero) DO NOTHING\n" +
                "    RETURNING idCoureur, NomCoureur, Numero\n" +
                "),\n" +
                "coureur_select AS (\n" +
                "    SELECT idCoureur, Numero\n" +
                "    FROM Coureur\n" +
                "    WHERE Numero IN (SELECT DISTINCT numcoureur FROM resultatcoursetemp)\n" +
                "),\n" +
                "insert_coureur_etape AS (\n" +
                "    INSERT INTO CoureurEtape (idEtape, idCoureur, DateHeureArrivee)\n" +
                "    SELECT e.idEtape, c.idCoureur, r.dateheurearrivee\n" +
                "    FROM resultatcoursetemp r\n" +
                "    JOIN (SELECT idEquipe, NomEquipe FROM equipe_insert\n" +
                "          UNION ALL\n" +
                "          SELECT idEquipe, NomEquipe FROM equipe_select) eq ON r.nomequipe = eq.NomEquipe\n" +
                "    JOIN (SELECT idCoureur, Numero FROM coureur_insert\n" +
                "          UNION ALL\n" +
                "          SELECT idCoureur, Numero FROM coureur_select) c ON r.numcoureur = c.Numero\n" +
                "    JOIN Etape e ON e.rang = r.rangetape\n" +
                "    LEFT JOIN CoureurEtape ce ON e.idEtape = ce.idEtape AND c.idCoureur = ce.idCoureur\n" +
                "    WHERE ce.idEtape IS NULL\n" +
                "    RETURNING idEtape, idCoureur, DateHeureArrivee\n" +
                ")\n" +
                "SELECT * FROM insert_coureur_etape;");

        } catch (Exception e) {
            throw e;
        }
        finally{
            st.close();
        }
    }
    
    public void insertPoints(Connection c,ArrayList<Points> lists)throws SQLException{
        Statement st = null;
        ArrayList<HashMap> erreur = new ArrayList<HashMap>();
        try {
            st = c.createStatement();
            st.executeUpdate("create temp table pointTemp(numligne serial,classement int,points int);");
            
            
            for (int i = 0; i < lists.size(); i++) {
                st.executeUpdate("insert into pointTemp values (default,"+lists.get(i).getClassement()+","+lists.get(i).getPoint()+");");
            }
            
            st.executeUpdate("INSERT INTO PointRang (Classement, Points) " +
                 "SELECT DISTINCT Classement, Points " +
                 "FROM pointTemp;");

            
        } catch (Exception e) {
            throw e;
        }
        finally{
            st.close();
        }
    }
    
    
    

    public static void main(String[] args){
    
        CsvUtilities imp = new CsvUtilities();
//        File f = new File("D:/Bossy/L3/S6/MrRojo/sujet2018FiomananaEval/IMPORT/Import.csv");
        File f = new File("D:/Bossy/L3/S6/Evaluation/ULTIMATE-TEAM-RACE/resultats.csv");
//        File f = new File("D:/Bossy/L3/S6/Evaluation/ULTIMATE-TEAM-RACE/etape.csv");
//            File f = new File("D:/Bossy/L3/S6/Evaluation/ULTIMATE-TEAM-RACE/point.csv");
        try {
            InputStream input = new FileInputStream(f);
            List<CSVRecord> ls = imp.getCsvData(input,',');
//            ArrayList<EtapeCourse> lst = imp.listeEtapeCourse(ls);
            ArrayList<ResultatCourse> lsrc = imp.listeResultatCourse(ls);
//                ArrayList<Points> lsrc = imp.listePoint(ls);
            
//            System.out.println(ls.size());
            
            ConnectBase cb = new ConnectBase();
            Connection c = cb.connectToDataBase();
            
            try {
//                imp.insertEtape(c, lst);
                imp.insertResultat(c, lsrc);
//                imp.insertPoints(c, lsrc);
            } catch (Exception e) {
                System.out.println(e);
            }
            finally{
                c.close();
            }
            
            
            
//            for(int i=0; i< ls.size(); i++){
//                System.out.println(ls.get(i).get("NumSeance")+"|"+ls.get(i).get("Film")+"|"+ls.get(i).get("Categorie")+"|"+ls.get(i).get("Salle")+"|"+ls.get(i).get("Date")+"|"+ls.get(i).get("Heure"));
//            }
//            ConnectBase cb = new ConnectBase();
//            Connection c = cb.connectToDataBase();
//             ArrayList<HashMap> insertion = imp.insertDataInTable(c, ls);
//             imp.insertMaisonData(c, ls);
//             imp.insertDevis(c, ls2);
             
//            if(insertion.isEmpty()) {
//                System.out.println("Insertion fait avec succes");
//            }
//            else{
//                for (int i = 0; i < insertion.size(); i++) {
//                    System.out.println("Erreur a "+insertion.get(i).toString());
//                }
//            }
             
        } catch (Exception ex) {
//            Logger.getLogger(CsvImport.class.getName()).log(Level.SEVERE, null, ex);
                System.out.println(ex);
        }
        
    
    }
    
    
    
}
