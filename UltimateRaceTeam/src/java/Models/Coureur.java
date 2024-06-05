/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import Utils.ConnectBase;
import java.sql.Date;
import java.text.SimpleDateFormat;

/**
 *
 * @author Ny Aina Ratolo
 */
public class Coureur {
    
    private int idcoureur;

    private String nomcoureur;

    private int numero;

    private char genre;

    private Date datenaissance;

    private int idequipe;



    public int getIdcoureur() { 
        return this.idcoureur; 
    }
    public String getNomcoureur() { 
        return this.nomcoureur; 
    }
    public int getNumero() { 
        return this.numero; 
    }
    public char getGenre() { 
        return this.genre; 
    }
    public Date getDatenaissance() { 
        return this.datenaissance; 
    }
    public int getIdequipe() { 
        return this.idequipe; 
    }


    public void setIdcoureur(int idcoureur) { 
        this.idcoureur = idcoureur; 
    }
    public void setNomcoureur(String nomcoureur) { 
        this.nomcoureur = nomcoureur; 
    }
    public void setNumero(int numero) { 
        this.numero = numero; 
    }
    public void setGenre(char genre) { 
        this.genre = genre; 
    }
    public void setDatenaissance(Date datenaissance) { 
        this.datenaissance = datenaissance; 
    }
    public void setIdequipe(int idequipe) { 
        this.idequipe = idequipe; 
    }

    public ArrayList<Coureur> getAllCoureur(Connection c) throws Exception{
        ArrayList<Coureur> lists = new ArrayList<>();
        String sql = "SELECT * FROM Coureur;";
        if(c!=null){
            Statement st = null;
            ResultSet rs=null;
            try{
                st = c.createStatement();
                rs = st.executeQuery(sql);

                while(rs.next()){
            Coureur list = new Coureur();
            list.setIdcoureur(rs.getInt("idcoureur"));
            list.setNomcoureur(rs.getString("nomcoureur"));
            list.setNumero(rs.getInt("numero"));
            list.setGenre(rs.getString("genre").charAt(0));
            list.setDatenaissance(rs.getDate("datenaissance"));
            list.setIdequipe(rs.getInt("idequipe"));
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
                Coureur list = new Coureur();
                list.setIdcoureur(rs.getInt("idcoureur"));
                list.setNomcoureur(rs.getString("nomcoureur"));
                list.setNumero(rs.getInt("numero"));
                list.setGenre(rs.getString("genre").charAt(0));
                list.setDatenaissance(rs.getDate("datenaissance"));
                list.setIdequipe(rs.getInt("idequipe"));
                lists.add(list);
                }
        }catch(Exception e){
            rs.close();
            st.close();
            cn.close();
            throw e;
        }
        finally{
            cn.close();
            rs.close();
            st.close();
        }

        }	return lists;

    }

    public Coureur getByIdCoureur(Connection c,String id) throws Exception{
            Coureur objet = new Coureur();
            String sql = "SELECT * FROM Coureur WHERE id='"+id+"';";
            if(c!=null){
                    Statement st = null;
                    ResultSet rs=null;
                    try{
                            st = c.createStatement();
                            rs = st.executeQuery(sql);

                            while(rs.next()){
                    Coureur obj = new Coureur();
                    obj.setIdcoureur(rs.getInt("idcoureur"));
                    obj.setNomcoureur(rs.getString("nomcoureur"));
                    obj.setNumero(rs.getInt("numero"));
                    obj.setGenre(rs.getString("genre").charAt(0));
                    obj.setDatenaissance(rs.getDate("datenaissance"));
                    obj.setIdequipe(rs.getInt("idequipe"));
                    objet=obj;
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
                            Coureur obj = new Coureur();
                            obj.setIdcoureur(rs.getInt("idcoureur"));
                            obj.setNomcoureur(rs.getString("nomcoureur"));
                            obj.setNumero(rs.getInt("numero"));
                            obj.setGenre(rs.getString("genre").charAt(0));
                            obj.setDatenaissance(rs.getDate("datenaissance"));
                            obj.setIdequipe(rs.getInt("idequipe"));
                            objet=obj;
                            }
            }catch(Exception e){
                    rs.close();
                    st.close();
                    cn.close();
                    throw e;
            }
             finally{
                    cn.close();
                    rs.close();
                    st.close();
            }

            }	return objet;
    }
    
    public ArrayList<Coureur> getAllCoureurByIdEquipe(Connection c,int id) throws Exception{
            ArrayList<Coureur> objet = new ArrayList<>();
            String sql = "SELECT * FROM Coureur WHERE idequipe="+id+";";
            if(c!=null){
                    Statement st = null;
                    ResultSet rs=null;
                    try{
                            st = c.createStatement();
                            rs = st.executeQuery(sql);

                            while(rs.next()){
                    Coureur obj = new Coureur();
                    obj.setIdcoureur(rs.getInt("idcoureur"));
                    obj.setNomcoureur(rs.getString("nomcoureur"));
                    obj.setNumero(rs.getInt("numero"));
                    obj.setGenre(rs.getString("genre").charAt(0));
                    obj.setDatenaissance(rs.getDate("datenaissance"));
                    obj.setIdequipe(rs.getInt("idequipe"));
                    objet.add(obj);
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
                            Coureur obj = new Coureur();
                            obj.setIdcoureur(rs.getInt("idcoureur"));
                            obj.setNomcoureur(rs.getString("nomcoureur"));
                            obj.setNumero(rs.getInt("numero"));
                            obj.setGenre(rs.getString("genre").charAt(0));
                            obj.setDatenaissance(rs.getDate("datenaissance"));
                            obj.setIdequipe(rs.getInt("idequipe"));
                            objet.add(obj);
                            }
            }catch(Exception e){
                    rs.close();
                    st.close();
                    cn.close();
                    throw e;
            }
             finally{
                    cn.close();
                    rs.close();
                    st.close();
            }
            }	return objet;
    }
    
    public ArrayList<Coureur> getAllCoureurEquipeNonInscriEtape(Connection c,int idEquipe,int idEtape) throws Exception{
            ArrayList<Coureur> objet = new ArrayList<>();
            String sql = "SELECT * FROM v_CoureurNonAffecterEtape WHERE idequipe="+idEquipe+" AND idEtape="+idEtape+";";
            if(c!=null){
                    Statement st = null;
                    ResultSet rs=null;
                    try{
                            st = c.createStatement();
                            rs = st.executeQuery(sql);

                            while(rs.next()){
                    Coureur obj = new Coureur();
                    obj.setIdcoureur(rs.getInt("idcoureur"));
                    obj.setNomcoureur(rs.getString("nomcoureur"));
                    obj.setNumero(rs.getInt("numero"));
                    obj.setGenre(rs.getString("genre").charAt(0));
                    obj.setDatenaissance(rs.getDate("datenaissance"));
                    obj.setIdequipe(rs.getInt("idequipe"));
                    objet.add(obj);
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
                            Coureur obj = new Coureur();
                            obj.setIdcoureur(rs.getInt("idcoureur"));
                            obj.setNomcoureur(rs.getString("nomcoureur"));
                            obj.setNumero(rs.getInt("numero"));
                            obj.setGenre(rs.getString("genre").charAt(0));
                            obj.setDatenaissance(rs.getDate("datenaissance"));
                            obj.setIdequipe(rs.getInt("idequipe"));
                            objet.add(obj);
                            }
            }catch(Exception e){
                    rs.close();
                    st.close();
                    cn.close();
                    throw e;
            }
             finally{
                    cn.close();
                    rs.close();
                    st.close();
            }
            }	return objet;
    }
    
    
    
}
