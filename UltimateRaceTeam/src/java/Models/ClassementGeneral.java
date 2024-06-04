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
public class ClassementGeneral {
    
    private int idEquipe;
    private String nomEquipe;
    private int point;
    private int rang;

    public int getIdEquipe() {
        return idEquipe;
    }

    public void setIdEquipe(int idEquipe) {
        this.idEquipe = idEquipe;
    }

    public String getNomEquipe() {
        return nomEquipe;
    }

    public void setNomEquipe(String nomEquipe) {
        this.nomEquipe = nomEquipe;
    }

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }

    public int getRang() {
        return rang;
    }

    public void setRang(int rang) {
        this.rang = rang;
    }

    public ClassementGeneral() {}

    public ClassementGeneral(int idEquipe, String nomEquipe, int point, int rang) {
        this.idEquipe = idEquipe;
        this.nomEquipe = nomEquipe;
        this.point = point;
        this.rang = rang;
    }
    
    public ArrayList<ClassementGeneral> getClassementGeneral() throws Exception{
        ArrayList<ClassementGeneral> listes = new ArrayList<>();
        
        String sql = "SELECT * FROM v_classementEquipe;";
        
        ConnectBase cb = new ConnectBase();
        Connection c = null;
        Statement st = null;
        ResultSet rs = null;
        
        try {
            c = cb.connectToDataBase();
            st = c.createStatement();
            rs = st.executeQuery(sql);
            
            while(rs.next()){
                ClassementGeneral ci = new ClassementGeneral();
                ci.setIdEquipe(rs.getInt("idEquipe"));
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
    
    public ArrayList<ClassementGeneral> getWinnerClassementGeneral() throws Exception{
        ArrayList<ClassementGeneral> listes = new ArrayList<>();
        
        String sql = "SELECT * FROM v_classementEquipe WHERE rang =1;";
        
        ConnectBase cb = new ConnectBase();
        Connection c = null;
        Statement st = null;
        ResultSet rs = null;
        
        try {
            c = cb.connectToDataBase();
            st = c.createStatement();
            rs = st.executeQuery(sql);
            
            while(rs.next()){
                ClassementGeneral ci = new ClassementGeneral();
                ci.setIdEquipe(rs.getInt("idEquipe"));
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
