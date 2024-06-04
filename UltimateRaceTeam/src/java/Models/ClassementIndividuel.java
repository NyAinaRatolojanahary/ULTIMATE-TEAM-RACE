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
import java.util.ArrayList;

/**
 *
 * @author Ny Aina Ratolo
 */
public class ClassementIndividuel {
    
    private int idCoureur;
    private String nomCoureur;
    private int numeroCoureur;
    private String nomEquipe;
    private int rang;
    private int point;

    public int getIdCoureur() {
        return idCoureur;
    }

    public void setIdCoureur(int idCoureur) {
        this.idCoureur = idCoureur;
    }

    public String getNomCoureur() {
        return nomCoureur;
    }

    public void setNomCoureur(String nomCoureur) {
        this.nomCoureur = nomCoureur;
    }

    public int getNumeroCoureur() {
        return numeroCoureur;
    }

    public void setNumeroCoureur(int numeroCoureur) {
        this.numeroCoureur = numeroCoureur;
    }

    public String getNomEquipe() {
        return nomEquipe;
    }

    public void setNomEquipe(String nomEquipe) {
        this.nomEquipe = nomEquipe;
    }

    public int getRang() {
        return rang;
    }

    public void setRang(int rang) {
        this.rang = rang;
    }

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }

    public ClassementIndividuel() {}

    public ClassementIndividuel(int idCoureur, String nomCoureur, int numeroCoureur, String nomEquipe, int rang, int point) {
        this.idCoureur = idCoureur;
        this.nomCoureur = nomCoureur;
        this.numeroCoureur = numeroCoureur;
        this.nomEquipe = nomEquipe;
        this.rang = rang;
        this.point = point;
    }
    
    public ArrayList<ClassementIndividuel> getClassementIndividuel() throws Exception{
        ArrayList<ClassementIndividuel> listes = new ArrayList<>();
        
        String sql = "SELECT * FROM v_classementindividuelpenalite;";
        
        ConnectBase cb = new ConnectBase();
        Connection c = null;
        Statement st = null;
        ResultSet rs = null;
        
        try {
            c = cb.connectToDataBase();
            st = c.createStatement();
            rs = st.executeQuery(sql);
            
            while(rs.next()){
                ClassementIndividuel ci = new ClassementIndividuel();
                ci.setIdCoureur(rs.getInt("idCoureur"));
                ci.setNomCoureur(rs.getString("NomCoureur"));
                ci.setNumeroCoureur(rs.getInt("Numero"));
                ci.setNomEquipe(rs.getString("NomEquipe"));
                ci.setRang(rs.getInt("rang"));
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
