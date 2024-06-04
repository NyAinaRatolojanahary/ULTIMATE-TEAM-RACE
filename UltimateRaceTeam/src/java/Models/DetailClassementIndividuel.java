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
import java.util.ArrayList;

/**
 *
 * @author Ny Aina Ratolo
 */
public class DetailClassementIndividuel {
    
    private String nomEtape;
    private String nomEquipe;
    private String nomCoureur;
    private Timestamp dateHeureDepart;
    private Timestamp dateHeureArrivee;
    private double duree;
    private int classement;
    private int point;

    public String getNomEtape() {
        return nomEtape;
    }

    public void setNomEtape(String nomEtape) {
        this.nomEtape = nomEtape;
    }

    public String getNomEquipe() {
        return nomEquipe;
    }

    public void setNomEquipe(String nomEquipe) {
        this.nomEquipe = nomEquipe;
    }

    public String getNomCoureur() {
        return nomCoureur;
    }

    public void setNomCoureur(String nomCoureur) {
        this.nomCoureur = nomCoureur;
    }

    public Timestamp getDateHeureDepart() {
        return dateHeureDepart;
    }

    public void setDateHeureDepart(Timestamp dateHeureDepart) {
        this.dateHeureDepart = dateHeureDepart;
    }

    public Timestamp getDateHeureArrivee() {
        return dateHeureArrivee;
    }

    public void setDateHeureArrivee(Timestamp dateHeureArrivee) {
        this.dateHeureArrivee = dateHeureArrivee;
    }

    public double getDuree() {
        return duree;
    }

    public void setDuree(double duree) {
        this.duree = duree;
    }

    public int getClassement() {
        return classement;
    }

    public void setClassement(int classement) {
        this.classement = classement;
    }

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }

    public DetailClassementIndividuel() {}

    public DetailClassementIndividuel(String nomEtape, String nomEquipe, String nomCoureur, Timestamp dateHeureDepart, Timestamp dateHeureArrivee, double duree, int classement, int point) {
        this.nomEtape = nomEtape;
        this.nomEquipe = nomEquipe;
        this.nomCoureur = nomCoureur;
        this.dateHeureDepart = dateHeureDepart;
        this.dateHeureArrivee = dateHeureArrivee;
        this.duree = duree;
        this.classement = classement;
        this.point = point;
    }
    
    public ArrayList<DetailClassementIndividuel> getDetailClassementIndividuel(int idCoureur) throws Exception{
        ArrayList<DetailClassementIndividuel> listes = new ArrayList<>();
        
        String sql = "SELECT * FROM v_coureurrangpenalite WHERE idCoureur="+idCoureur+";";
        
        ConnectBase cb = new ConnectBase();
        Connection c = null;
        Statement st = null;
        ResultSet rs = null;
        
        try {
            c = cb.connectToDataBase();
            st = c.createStatement();
            rs = st.executeQuery(sql);
            
            while(rs.next()){
                DetailClassementIndividuel ci = new DetailClassementIndividuel();
                ci.setNomEtape(rs.getString("NomEtape"));
                ci.setNomCoureur(rs.getString("NomCoureur"));
                ci.setNomEquipe(rs.getString("NomEquipe"));
                ci.setDateHeureDepart(rs.getTimestamp("DateHeureDepart"));
                ci.setDateHeureArrivee(rs.getTimestamp("DateHeureArrivee"));
                ci.setDuree(rs.getDouble("hour_diff"));
                ci.setClassement(rs.getInt("classement"));
                ci.setPoint(rs.getInt("points"));
                
                listes.add(ci);
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
    
}
