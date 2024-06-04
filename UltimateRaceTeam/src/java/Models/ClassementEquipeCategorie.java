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
public class ClassementEquipeCategorie {
    
    private String nomEquipe;
    private String nomCategorie;
    private int totalPoints;
    private int classement;

    public String getNomEquipe() {
        return nomEquipe;
    }

    public void setNomEquipe(String nomEquipe) {
        this.nomEquipe = nomEquipe;
    }

    public String getNomCategorie() {
        return nomCategorie;
    }

    public void setNomCategorie(String nomCategorie) {
        this.nomCategorie = nomCategorie;
    }

    public int getTotalPoints() {
        return totalPoints;
    }

    public void setTotalPoints(int totalPoints) {
        this.totalPoints = totalPoints;
    }

    public int getClassement() {
        return classement;
    }

    public void setClassement(int classement) {
        this.classement = classement;
    }

    public ClassementEquipeCategorie() {}

    public ClassementEquipeCategorie(String nomEquipe, String nomCategorie, int totalPoints, int classement) {
        this.nomEquipe = nomEquipe;
        this.nomCategorie = nomCategorie;
        this.totalPoints = totalPoints;
        this.classement = classement;
    }
    
    public ArrayList<ClassementEquipeCategorie> getClassementEquipeParCategorie(int idCategorie) throws Exception{
        ArrayList<ClassementEquipeCategorie> listes = new ArrayList<>();
        
        ConnectBase cb = new ConnectBase();
        Connection c = null;
        Statement st = null;
        ResultSet rs = null;
        
        String sql = "SELECT * FROM v_ClassementGeneralEquipeCategoriePenalite WHERE idCategorie="+idCategorie+";";
        
        try {
            c = cb.connectToDataBase();
            st = c.createStatement();
            rs = st.executeQuery(sql);
            
            while(rs.next()){
                ClassementEquipeCategorie clec = new ClassementEquipeCategorie();
                clec.setNomCategorie(rs.getString("nomcategorie"));
                clec.setNomEquipe(rs.getString("nomequipe"));
                clec.setTotalPoints(rs.getInt("totalpoints"));
                clec.setClassement(rs.getInt("classementequipe"));
                listes.add(clec);
            }
            
        } catch (Exception e) {
            throw e;
        }
        finally{
            c.close();
            st.close();
        }
        
        return listes;
    }
    
}
