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
import java.sql.Time;
import java.util.ArrayList;

/**
 *
 * @author Ny Aina Ratolo
 */
public class DetailClassementIndividuelEtape {
    
    private String nomCoureur;
    private char genre;
    private Time chrono;
    private Time penalite;
    private Time tempsFinal;
    private int rang;
    private String nomEtape;

    public String getNomCoureur() {
        return nomCoureur;
    }

    public void setNomCoureur(String nomCoureur) {
        this.nomCoureur = nomCoureur;
    }

    public char getGenre() {
        return genre;
    }

    public void setGenre(char genre) {
        this.genre = genre;
    }

    public Time getChrono() {
        return chrono;
    }

    public void setChrono(Time chrono) {
        this.chrono = chrono;
    }

    public Time getPenalite() {
        return penalite;
    }

    public void setPenalite(Time penalite) {
        this.penalite = penalite;
    }

    public Time getTempsFinal() {
        return tempsFinal;
    }

    public void setTempsFinal(Time tempsFinal) {
        this.tempsFinal = tempsFinal;
    }

    public int getRang() {
        return rang;
    }

    public void setRang(int rang) {
        this.rang = rang;
    }

    public String getNomEtape() {
        return nomEtape;
    }

    public void setNomEtape(String nomEtape) {
        this.nomEtape = nomEtape;
    }
    
    

    public DetailClassementIndividuelEtape() {}

    public DetailClassementIndividuelEtape(String nomCoureur, char genre, Time chrono, Time penalite, Time tempsFinal, int rang, String nomEtape) {
        this.nomCoureur = nomCoureur;
        this.genre = genre;
        this.chrono = chrono;
        this.penalite = penalite;
        this.tempsFinal = tempsFinal;
        this.rang = rang;
        this.nomEtape = nomEtape;
    }

    
    
    public ArrayList<DetailClassementIndividuelEtape> getClassementIndividuelParEtape(int idEtape) throws Exception{
        ArrayList<DetailClassementIndividuelEtape> listes = new ArrayList<>();
        
        String sql = " select * from v_CoureurEtapeClassementPenalite WHERE idEtape="+idEtape+";";
        
        ConnectBase cb = new ConnectBase();
        Connection c = null;
        Statement st = null;
        ResultSet rs = null;
        
        try {
            c = cb.connectToDataBase();
            st = c.createStatement();
            rs = st.executeQuery(sql);
            
            while(rs.next()){
                DetailClassementIndividuelEtape ci = new DetailClassementIndividuelEtape();
                ci.setNomCoureur(rs.getString("nomcoureur"));
                ci.setGenre(rs.getString("genre").charAt(0));
                ci.setChrono(rs.getTime("chrono"));
                ci.setPenalite(rs.getTime("penalite"));
                ci.setTempsFinal(rs.getTime("diff"));
                ci.setRang(rs.getInt("classement"));
                ci.setNomEtape(rs.getString("nometape"));
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
