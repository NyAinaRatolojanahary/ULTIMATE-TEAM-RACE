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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

/**
 *
 * @author Ny Aina Ratolo
 */
public class EtapeCourse {
    
    private int idetape;

    private String nometape;

    private double longueur;

    private int nbrcoureurequipe;

    private Timestamp dateheuredepart;

    private int idcourse;
    
    private int rang;



    public int getIdetape() { 
        return this.idetape; 
    }
    
    public String getNometape() { 
	 return this.nometape; 
    }
    
    public double getLongueur() { 
	 return this.longueur; 
    }
    
    public int getNbrcoureurequipe() { 
	 return this.nbrcoureurequipe; 
    }
 
    public Timestamp getDateheuredepart() { 
	 return this.dateheuredepart; 
    }
 
    public int getIdcourse() { 
	 return this.idcourse; 
    }


    public void setIdetape(int idetape) { 
 	 this.idetape = idetape; 
    }
 
    public void setNometape(String nometape) { 
 	 this.nometape = nometape; 
    }
    
    public void setLongueur(double longueur) { 
 	 this.longueur = longueur; 
    }
 
    public void setNbrcoureurequipe(int nbrcoureurequipe) { 
 	 this.nbrcoureurequipe = nbrcoureurequipe; 
    }
 
    public void setDateheuredepart(Timestamp dateheuredepart) { 
 	 this.dateheuredepart = dateheuredepart; 
    }
    
    public void setDateheuredepart(String dateheuredepart) throws Exception{
         if(dateheuredepart.isEmpty()){
            throw new NullPointerException("Date de depart incorrect");
        }
        else{
            DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            LocalDateTime dateTime = LocalDateTime.parse(dateheuredepart, inputFormatter);

            DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String outputDateString = dateTime.format(outputFormatter);
             
            Timestamp datedepart = Timestamp.valueOf(outputDateString);
            
            this.dateheuredepart = datedepart;
        }
    }
    
    public void setIdcourse(int idcourse) { 
 	 this.idcourse = idcourse; 
    }

    public int getRang() {
        return rang;
    }

    public void setRang(int rang) {
        this.rang = rang;
    }
    
    

    public EtapeCourse() {}

    public EtapeCourse(String nometape, double longueur, int nbrcoureurequipe, int rang, Timestamp dateheuredepart) {
        this.nometape = nometape;
        this.longueur = longueur;
        this.nbrcoureurequipe = nbrcoureurequipe;
        this.rang = rang;
        this.dateheuredepart = dateheuredepart;
    }

    public EtapeCourse(int idetape, String nometape, double longueur, int nbrcoureurequipe, Timestamp dateheuredepart) {
        this.idetape = idetape;
        this.nometape = nometape;
        this.longueur = longueur;
        this.nbrcoureurequipe = nbrcoureurequipe;
        this.rang = rang;
        this.dateheuredepart = dateheuredepart;
    }
    

    public ArrayList<EtapeCourse> getAllEtape(Connection c) throws Exception{
        ArrayList<EtapeCourse> lists = new ArrayList<>();
        String sql = "SELECT * FROM Etape;";
        if(c!=null){
                Statement st = null;
                ResultSet rs=null;
                try{
                        st = c.createStatement();
                        rs = st.executeQuery(sql);

                        while(rs.next()){
                EtapeCourse list = new EtapeCourse();
                list.setIdetape(rs.getInt("idetape"));
                list.setNometape(rs.getString("nometape"));
                list.setLongueur(rs.getDouble("longueur"));
                list.setNbrcoureurequipe(rs.getInt("nbrcoureurequipe"));
                list.setDateheuredepart(rs.getTimestamp("dateheuredepart"));
                list.setRang(rs.getInt("rang"));
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
			EtapeCourse list = new EtapeCourse();
			list.setIdetape(rs.getInt("idetape"));
			list.setNometape(rs.getString("nometape"));
			list.setLongueur(rs.getDouble("longueur"));
			list.setNbrcoureurequipe(rs.getInt("nbrcoureurequipe"));
			list.setDateheuredepart(rs.getTimestamp("dateheuredepart"));
                        list.setRang(rs.getInt("rang"));
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

    public EtapeCourse getByIdEtape(Connection c,int id) throws Exception{
        EtapeCourse objet = new EtapeCourse();
        String sql = "SELECT * FROM Etape WHERE idEtape="+id+";";
        if(c!=null){
                Statement st = null;
                ResultSet rs=null;
                try{
                        st = c.createStatement();
                        rs = st.executeQuery(sql);

                        while(rs.next()){
                EtapeCourse obj = new EtapeCourse();
                obj.setIdetape(rs.getInt("idetape"));
                obj.setNometape(rs.getString("nometape"));
                obj.setLongueur(rs.getDouble("longueur"));
                obj.setNbrcoureurequipe(rs.getInt("nbrcoureurequipe"));
                obj.setDateheuredepart(rs.getTimestamp("dateheuredepart"));
                obj.setRang(rs.getInt("rang"));
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
			EtapeCourse obj = new EtapeCourse();
			obj.setIdetape(rs.getInt("idetape"));
			obj.setNometape(rs.getString("nometape"));
			obj.setLongueur(rs.getDouble("longueur"));
			obj.setNbrcoureurequipe(rs.getInt("nbrcoureurequipe"));
			obj.setDateheuredepart(rs.getTimestamp("dateheuredepart"));
                        obj.setRang(rs.getInt("rang"));
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
    
    public void insertEtape(Connection c,int idetape,String nometape,double longueur,int nbrcoureurequipe,Timestamp dateheuredepart,int rang) throws Exception{
        String sql = "INSERT INTO Etape VALUES ("+idetape+",'"+nometape+"',"+longueur+","+nbrcoureurequipe+",'"+dateheuredepart+"',"+rang+");";
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
    
    public ArrayList<EtapeCourse> getEtapeEquipe(int idEquipe) throws Exception{
        ArrayList<EtapeCourse> listes = new ArrayList<>();
        
        ConnectBase cb = new ConnectBase();
        Connection c = null;
        Statement st = null;
        ResultSet rs = null;
        
        String sql = "SELECT * FROM v_etapeequipe WHERE idEquipe="+idEquipe+";";
        
        try {
            c = cb.connectToDataBase();
            st = c.createStatement();
            rs = st.executeQuery(sql);
            
            while(rs.next()){
                EtapeCourse ec = new EtapeCourse();
                ec.setNometape(rs.getString("nometape"));
                ec.setLongueur(rs.getDouble("longueur"));
                ec.setNbrcoureurequipe(rs.getInt("nbrcoureurequipe"));
                ec.setIdetape(rs.getInt("idetape"));
                listes.add(ec);
            }
            
        } catch (Exception e) {
            throw e;
        }
        
        return listes;
    }
    
    public int getNombreCoureurEtape(int idEtape) throws Exception{
        int nbr = 0;
        
        ConnectBase cb = new ConnectBase();
        Connection c = null;
        Statement st = null;
        ResultSet rs = null;
        
        String sql = "SELECT nombrecoureurequipe FROM etape WHERE idEtape="+idEtape+";";
        
        try {
            c = cb.connectToDataBase();
            st = c.createStatement();
            rs = st.executeQuery(sql);
            
            while(rs.next()){
                nbr = rs.getInt("nombrecoureurequipe");
            }
            
        } catch (Exception e) {
            throw e;
        }
        
        return nbr;
    }
    
    
    public String convertDate(String date){
        SimpleDateFormat formatdateEntree = new SimpleDateFormat("dd/MM/yyyy");
        SimpleDateFormat formatdateSortie = new SimpleDateFormat("yyyy-MM-dd");
        
        Date dateToFormat = null;
        String formatedDate = null;
        
        try {
            dateToFormat = formatdateEntree.parse(date);
            formatedDate = formatdateSortie.format(dateToFormat);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return formatedDate;
    }
    
    public Timestamp composeDateHeureDepart(String date, String heure){
        SimpleDateFormat formatdateHeureDepart = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateTimeStr = date+" "+heure;
        
        Timestamp ts = null;
        
        try {
            Date parsedDate = formatdateHeureDepart.parse(dateTimeStr);
            
            ts = new Timestamp(parsedDate.getTime());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ts;
    }
    
    public double convertDouble(String nombre){
        String aConvertir = nombre.replace(',', '.');
        double nbr = Double.parseDouble(aConvertir);
        return nbr;
    }
    
    public static void main(String[] args){
        EtapeCourse et = new EtapeCourse();
//        String date = "01/06/2024";
//        String heure = "09:00:00";
//        
//        String val=null;
//        
//        Timestamp ts = null;
//        
//        try {
//            val = et.convertDate(date);
//            System.out.println(val);
//            ts = et.composeDateHeureDepart(val, heure);
//            System.out.println(ts);
//        } catch (Exception e) {
//            System.out.println(e);
//        }
    double d = 0;
    d = et.convertDouble("8,6");
        System.out.println(d);
    }
    
}
