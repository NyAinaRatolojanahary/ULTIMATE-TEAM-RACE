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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Ny Aina Ratolo
 */
public class ClassementEquipeCategorie {
    
    private String nomEquipe;
    private String nomCategorie;
    private int totalPoints;
    private int classement;
    private int loko;

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

    public int getLoko() {
        return loko;
    }

    public void setLoko(int loko) {
        this.loko = loko;
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
    
    public ArrayList<ClassementEquipeCategorie> mandoko(ArrayList<ClassementEquipeCategorie> liste) {
        for (int i = 0; i < liste.size(); i++) {
            boolean execo = false;
            for (int j = 0; j < liste.size(); j++) {
                if (i != j && liste.get(i).getTotalPoints() == liste.get(j).getTotalPoints()) {
                    execo = true;
                    break;
                }
            }
            liste.get(i).setLoko(execo ? 1 : 0);
        }
        return liste;
    }
    
    public static void main(String[] args){
    
        ClassementEquipeCategorie cg = new ClassementEquipeCategorie();
        
        try {
            ArrayList<ClassementEquipeCategorie> lscg = cg.getClassementEquipeParCategorie(5);
            ArrayList<ClassementEquipeCategorie> lsm = cg.mandoko(lscg);
            
            System.out.println(lsm.size());
            
            for (int i = 0; i < lsm.size(); i++) {
                System.out.println(lsm.get(i).getLoko());
            }
            
        } catch (Exception ex) {
            Logger.getLogger(ClassementEquipeCategorie.class.getName()).log(Level.SEVERE, null, ex);
        }
    
    }
    
}
