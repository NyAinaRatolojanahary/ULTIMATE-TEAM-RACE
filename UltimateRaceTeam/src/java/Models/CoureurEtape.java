/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

import Utils.ConnectBase;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Ny Aina Ratolo
 */
public class CoureurEtape {
    
    private int idEtape;
    private int idCoureur;
    private String nomEtape;
    private String nomCoureur;
    private int numero;
    private Timestamp dateHeureArrivee;
    private String tempsPasse;

    public int getIdEtape() {
        return idEtape;
    }

    public void setIdEtape(int idEtape) {
        this.idEtape = idEtape;
    }

    public int getIdCoureur() {
        return idCoureur;
    }

    public void setIdCoureur(int idCoureur) {
        this.idCoureur = idCoureur;
    }

    public String getNomEtape() {
        return nomEtape;
    }

    public void setNomEtape(String nomEtape) {
        this.nomEtape = nomEtape;
    }

    public String getNomCoureur() {
        return nomCoureur;
    }

    public void setNomCoureur(String nomCoureur) {
        this.nomCoureur = nomCoureur;
    }

    public int getNumero() {
        return numero;
    }

    public void setNumero(int numero) {
        this.numero = numero;
    }

    public Timestamp getDateHeureArrivee() {
        return dateHeureArrivee;
    }

    public void setDateHeureArrivee(Timestamp dateHeureArrivee) {
        this.dateHeureArrivee = dateHeureArrivee;
    }
    
    public void setDateHeureArrivee(String dateheuredearrivee) throws Exception {
        if(dateheuredearrivee.isEmpty()){
            throw new NullPointerException("Date d'arrivee incorrect");
        } else {
            DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            LocalDateTime dateTime = LocalDateTime.parse(dateheuredearrivee, inputFormatter);

            // Convertir directement en Timestamp
            Timestamp datearrivee = Timestamp.valueOf(dateTime);

            this.dateHeureArrivee = datearrivee;
        }
    }

    public String getTempsPasse() {
        return tempsPasse;
    }

    public void setTempsPasse(String tempsPasse) {
        this.tempsPasse = tempsPasse;
    }
    
    


    public CoureurEtape() {}

    public CoureurEtape(int idEtape, int idCoureur, String nomEtape, String nomCoureur,int numero,Timestamp dateHeureArrivee) {
        this.idEtape = idEtape;
        this.idCoureur = idCoureur;
        this.nomEtape = nomEtape;
        this.nomCoureur = nomCoureur;
        this.numero = numero;
        this.dateHeureArrivee = dateHeureArrivee;
    }

    
    
    public void ajouterCoureurEtape(int idEtape,int idCoureur) throws Exception{
    
        String sql = "INSERT INTO CoureurEtape (idetape,idcoureur) values ("+idEtape+","+idCoureur+");";
        
        ConnectBase cb = new ConnectBase();
        Connection c = null;
        Statement st = null;
        
        try {
            c = cb.connectToDataBase();
            st = c.createStatement();
            st.executeUpdate(sql);
            
        } catch (Exception e) {
            throw new Exception("Insertion Annuler");
        }
        finally{
            c.close();
            st.close();
        }
    }
    
    public ArrayList<CoureurEtape> getAllCoureurNonArriveeEtape(int idEtape) throws Exception{
        ArrayList<CoureurEtape> listes = new ArrayList<>();
        
        ConnectBase cb = new ConnectBase();
        Connection c = null;
        Statement st = null;
        ResultSet rs = null;
        
        String sql = "SELECT * FROM v_CoureurEtapeNonArrivee WHERE idEtape="+idEtape+";";
        
        try {
            c = cb.connectToDataBase();
            st = c.createStatement();
            rs = st.executeQuery(sql);
            
            while(rs.next()){
                CoureurEtape coureur = new CoureurEtape();
                coureur.setIdEtape(rs.getInt("idEtape"));
                coureur.setNomEtape(rs.getString("nomEtape"));
                coureur.setIdCoureur(rs.getInt("idCoureur"));
                coureur.setNomCoureur(rs.getString("nomCoureur"));
                coureur.setNumero(rs.getInt("numero"));
                listes.add(coureur);
            }
            
        } catch (Exception e) {
            throw e;
        }
        finally{
            c.close();
            st.close();
            rs.close();
        }
        
        return listes;
    }
    
    public void InsertTempsCoureur(Connection c,int idEtape,int idCoureur,Timestamp temps) throws Exception{
        
        String sql = "UPDATE CoureurEtape set dateHeureArrivee='"+temps+"' WHERE idetape="+idEtape+" AND idcoureur="+idCoureur+";";
        Statement st = null;
        
        try {
            st = c.createStatement();
            
            st.executeUpdate(sql);
        } catch (Exception e) {
            throw e;
        }
        finally{
            st.close();
        }
    
    }
    
    public ArrayList<CoureurEtape> tempsPasseCoureurEtape(int idEquipe,int idEtape){
        ArrayList<CoureurEtape> listes = new ArrayList<>();
        
        ConnectBase cb = new ConnectBase();
        Connection c = null;
        Statement st = null;
        ResultSet rs = null;
        
        String sql = "SELECT * FROM v_TempsPasseCoureurEtape WHERE idEtape = "+idEtape+" AND idEquipe="+idEquipe+";";
        
        try {
            c = cb.connectToDataBase();
            st = c.createStatement();
            rs = st.executeQuery(sql);
            
            while(rs.next()){
                CoureurEtape ce = new CoureurEtape();
                ce.setNomCoureur(rs.getString("nomCoureur"));
                ce.setTempsPasse(rs.getString("diff"));
                listes.add(ce);
            }
            
        } catch (Exception e) {
        }
        
        return listes;
    }
    
    public int nombreCoureurRestanteAutoriseeEtape(int idEtape,int idEquipe) throws Exception{
        int result = 0;
        
        ConnectBase cb = new ConnectBase();
        Connection c = null;
        Statement st = null;
        ResultSet rs = null;
        
        String sql = "SELECT * from v_NbrCoureurAssignableEtape WHERE  v_nbrcoureurassignableetape.idEtape="+idEtape+" AND v_nbrcoureurassignableetape.idEquipe="+idEquipe+";";
        
        try {
            c = cb.connectToDataBase();
            st = c.createStatement();
            rs = st.executeQuery(sql);
            
            while(rs.next()){
                result  = rs.getInt("NombreCoureurRestant");
            }
            
        } catch (Exception e) {
            throw e;
        }
        
        return result;
    }
    
    public static void main(String[] args){
         
        CoureurEtape ce = new CoureurEtape();
//        ce.setIdEtape(3);
//        ce.setIdCoureur(1);
        try {
//            ce.setDateHeureArrivee("2024-06-02T14:37");
//            
//            ce.InsertTempsCoureur(null,ce.getIdEtape(), ce.getIdCoureur(), ce.getDateHeureArrivee());
//            ArrayList<CoureurEtape> ls = new ArrayList<>();
//            ls = ce.tempsPasseCoureurEtape(158, 24);
            
//            System.out.println(ls.get(0).getTempsPasse());

                int nbr = ce.nombreCoureurRestanteAutoriseeEtape(20, 155);
                System.out.println(nbr);
            
        } catch (Exception ex) {
            Logger.getLogger(CoureurEtape.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
