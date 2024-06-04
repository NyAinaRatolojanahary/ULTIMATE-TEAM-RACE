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
import java.text.ParseException;
import java.util.ArrayList;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Ny Aina Ratolo
 */
public class Penalite {
    
    private int idEtape;
    private String nomEtape;
    private int idEquipe;
    private String nomEquipe;
    private Time penalite;

    public int getIdEtape() {
        return idEtape;
    }

    public void setIdEtape(int idEtape) {
        this.idEtape = idEtape;
    }

    public int getIdEquipe() {
        return idEquipe;
    }

    public void setIdEquipe(int idEquipe) {
        this.idEquipe = idEquipe;
    }

    public Time getPenalite() {
        return penalite;
    }

    public void setPenalite(Time penalite) {
        this.penalite = penalite;
    }

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
    
    

    public Penalite() {}

    public Penalite(int idEtape, String nomEtape, int idEquipe, String nomEquipe, Time penalite) {
        this.idEtape = idEtape;
        this.nomEtape = nomEtape;
        this.idEquipe = idEquipe;
        this.nomEquipe = nomEquipe;
        this.penalite = penalite;
    }

    
    
    public ArrayList<Penalite> getAllPenalite(Connection c) throws Exception{
        ArrayList<Penalite> lists = new ArrayList<>();
        String sql = "SELECT * FROM v_PenaliteEquipe;";
        if(c!=null){
            Statement st = null;
            ResultSet rs=null;
            try{
                st = c.createStatement();
                rs = st.executeQuery(sql);

                while(rs.next()){
                    Penalite list = new Penalite();
                    list.setIdEtape(rs.getInt("idetape"));
                    list.setNomEtape(rs.getString("nometape"));
                    list.setIdEquipe(rs.getInt("idequipe"));
                    list.setNomEquipe(rs.getString("nomequipe"));
                    list.setPenalite(rs.getTime("tempspenalite"));
                    lists.add(list);
                }
            }catch(Exception e){
                rs.close();
                st.close();
                throw e;
            }
            finally{
                rs.close();
                st.close();
            }
        }
        else{
            ConnectBase cb = new ConnectBase();
            Connection cn = null;
            Statement st = null;
            ResultSet rs = null;
            try{
                cn = cb.connectToDataBase();
                st = cn.createStatement();
                rs = st.executeQuery(sql);

                while(rs.next()){
                    Penalite list = new Penalite();
                    list.setIdEtape(rs.getInt("idetape"));
                    list.setNomEtape(rs.getString("nometape"));
                    list.setIdEquipe(rs.getInt("idequipe"));
                    list.setNomEquipe(rs.getString("nomequipe"));
                    list.setPenalite(rs.getTime("tempspenalite"));
                    lists.add(list);
                }
            }
            catch(Exception e){
                rs.close();
                st.close();
                cn.close();
                throw e;
            }finally{
                cn.close();
                rs.close();
                st.close();
            }

        }	
        return lists;

    }
    
    public void insertPenaliteEquipe(Connection c,int idetape,int idequipe,Time tempsPenalite) throws Exception{
        String sql = "INSERT INTO Penaliteequipe VALUES ("+idetape+","+idequipe+",'"+tempsPenalite+"');";
        
        if(c!=null){
            Statement st = null;
            try{
                st = c.createStatement();
                st.executeUpdate(sql);
            }catch(Exception e){
                st.close();
                c.rollback();
                throw e;
            }
            finally{
                st.close();
            }
        }
        else{
            ConnectBase cb = new ConnectBase();
            Connection cn = null;
            Statement st = null;
            try{
            cn = cb.connectToDataBase();
            st = cn.createStatement();
            st.executeUpdate(sql);

            }catch(Exception e){
                    cn.rollback();
                    st.close();
                    cn.close();
                    throw e;
            }
            finally{
                cn.commit();
                cn.close();
                st.close();
            }

        }
    }
    
    public void deletePenaliteEquipe(Connection c,int idetape,int idEquipe) throws Exception{
        String sql = "DELETE FROM PenaliteEquipe WHERE idetape="+idetape+" AND idEquipe="+idEquipe+";";
        if(c!=null){
            Statement st = null;
            try{
                st = c.createStatement();
                st.executeUpdate(sql);

            }catch(Exception e){
                st.close();
                c.rollback();
                throw e;
            }
            finally{
                st.close();
            }
        }
        else{
            ConnectBase cb = new ConnectBase();
            Connection cn = null;
            Statement st = null;
            try{
                cn = cb.connectToDataBase();
                st = cn.createStatement();
                st.executeUpdate(sql);
            }catch(Exception e){
                st.close();
                cn.close();
                throw e;
            }
            finally{
                cn.close();
                st.close();
            }

        }
    }
    
    public Time convertStringEnTime(String temps) throws ParseException{
        SimpleDateFormat formater = new SimpleDateFormat("HH:mm:ss");
        try {
            Date date = formater.parse(temps);
            Time time = new Time(date.getTime());
            return time;
        } catch (ParseException parseException) {
            throw parseException;
        }
    }
    
}
