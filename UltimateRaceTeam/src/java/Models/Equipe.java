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
public class Equipe {
    
    private int idequipe;

    private String nomequipe;

    private String mail;

    private String pwd;



    public int getIdequipe() { 
        return this.idequipe; 
    }
    public String getNomequipe() { 
        return this.nomequipe; 
    }
    public String getMail() { 
        return this.mail; 
    }
    public String getPwd() { 
        return this.pwd; 
    }


    public void setIdequipe(int idequipe) { 
        this.idequipe = idequipe; 
    }
    public void setNomequipe(String nomequipe) { 
        this.nomequipe = nomequipe; 
    }
    public void setMail(String mail) { 
        this.mail = mail; 
    }
    public void setPwd(String pwd) { 
        this.pwd = pwd; 
    }
    
    public Equipe authentifierEquipe(Connection c,String email,String password)throws Exception{
        Equipe user = null; 
        
        if(c!=null){
            Statement st = null;
            ResultSet rs = null;
            String sql1 = "SELECT * FROM equipe WHERE mail='"+email+"';";
            try{
                st = c.createStatement();
                rs = st.executeQuery(sql1);
                if(rs.next()){
                    String sql2 = "SELECT * FROM equipe WHERE mail='"+email+"' AND pwd='"+password+"';";
                    try{
                        rs = st.executeQuery(sql2);
                        if(rs.next()){
                            Equipe usr = new Equipe();
                            usr.setIdequipe(rs.getInt("idEquipe"));
                            usr.setNomequipe(rs.getString("nomEquipe"));
                            usr.setMail(rs.getString("mail"));
                            user = usr;
                        }
                        else{
                            throw new Exception("Votre mot de passe est incorrect!!");
                        }
                    }catch(Exception e){
                        throw e;
                    }
                }
                else{
                    throw new Exception("Votre email est incorrect !!");
                }

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
                ResultSet rs = null;
                String sql1 = "SELECT * FROM equipe WHERE mail='"+email+"'";
                try{
                    cn = cb.connectToDataBase();
                    st = cn.createStatement();
                    rs = st.executeQuery(sql1);
                    
                        
                    if(rs.next()){
                        String sql2 = "SELECT * FROM equipe WHERE mail='"+email+"' AND pwd='"+password+"';";
                        try{
                            rs = st.executeQuery(sql2);
                            if(rs.next()){
                                Equipe usr = new Equipe();
                                usr.setIdequipe(rs.getInt("idEquipe"));
                                usr.setNomequipe(rs.getString("nomEquipe"));
                                usr.setMail(rs.getString("mail"));
                                user = usr;
                            }
                            else{
                                throw new Exception("Votre mot de passe est incorrect!!");
                            }
                        }catch(Exception e){
                            throw e;
                        }
                    }
                    else{
                        throw new Exception("Votre email est incorrect!!");
                    }

                }catch(Exception e){
//                        cn.rollback();
                        st.close();
                        cn.close();
                        throw e;
                }
                 finally{
//                cn.commit();
                        cn.close();
                        st.close();
                }

        }
        return user;
    }

    public ArrayList<Equipe> getAllEquipe(Connection c) throws Exception{
        ArrayList<Equipe> lists = new ArrayList<>();
        String sql = "SELECT * FROM Equipe;";
        if(c!=null){
                Statement st = null;
                ResultSet rs=null;
                try{
                        st = c.createStatement();
                        rs = st.executeQuery(sql);

                        while(rs.next()){
                Equipe list = new Equipe();
                list.setIdequipe(rs.getInt("idequipe"));
                list.setNomequipe(rs.getString("nomequipe"));
                list.setMail(rs.getString("mail"));
                list.setPwd(rs.getString("pwd"));
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
			Equipe list = new Equipe();
			list.setIdequipe(rs.getInt("idequipe"));
			list.setNomequipe(rs.getString("nomequipe"));
			list.setMail(rs.getString("mail"));
			list.setPwd(rs.getString("pwd"));
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

    public Equipe getByIdEquipe(Connection c,String id) throws Exception{
    Equipe objet = new Equipe();
    String sql = "SELECT * FROM Equipe WHERE id='"+id+"';";
    if(c!=null){
            Statement st = null;
            ResultSet rs=null;
            try{
                    st = c.createStatement();
                    rs = st.executeQuery(sql);

                    while(rs.next()){
            Equipe obj = new Equipe();
            obj.setIdequipe(rs.getInt("idequipe"));
            obj.setNomequipe(rs.getString("nomequipe"));
            obj.setMail(rs.getString("mail"));
            obj.setPwd(rs.getString("pwd"));
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
			Equipe obj = new Equipe();
            obj.setIdequipe(rs.getInt("idequipe"));
            obj.setNomequipe(rs.getString("nomequipe"));
            obj.setMail(rs.getString("mail"));
            obj.setPwd(rs.getString("pwd"));
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
    
}
    
    
    
