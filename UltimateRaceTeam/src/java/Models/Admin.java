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

/**
 *
 * @author Ny Aina Ratolo
 */
public class Admin {
    
    private int idAdmin;
    private String email;
    private String pwd;

    public int getIdAdmin() {
        return idAdmin;
    }

    public void setIdAdmin(int idAdmin) {
        this.idAdmin = idAdmin;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }
    
    public boolean findEmailAdmin(String email)throws Exception{
        
        boolean value = false;
        String emailToSearch = email.trim();
        
        ConnectBase cb = new ConnectBase();
        Connection c = null;
        Statement st = null;
        ResultSet rs = null;
        
        String sql = "SELECT * FROM admin WHERE mail='"+ emailToSearch+"';";
        
        try {
            c = cb.connectToDataBase();
            st = c.createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {
                value = true;
            }
        } catch (Exception e) {
            throw e;
        }
        finally{
            c.close();
            st.close();
            rs.close();
        }
    
        return value;
    }
    
    public boolean verifyPassword(String mail,String password) throws Exception{
        boolean value = false;
        String emailToSearch = mail.trim();
        String pwd = password.trim();
        
        ConnectBase cb = new ConnectBase();
        Connection c = null;
        Statement st = null;
        ResultSet rs = null;
        
        String sql = "SELECT * FROM admin WHERE mail='"+ emailToSearch+"' AND pwd='"+pwd+"';";
        
        try {
            c = cb.connectToDataBase();
            st = c.createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {
                value = true;
            }
        } catch (Exception e) {
            throw e;
        }
        finally{
            c.close();
            st.close();
            rs.close();
        }
    
        return value;
    }
    
    public static void main(String[] args) {
        Admin adm = new Admin();
        
        try {
            boolean b = adm.verifyPassword("admin@gmail.com", "admi");
            System.out.println(b);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }
    
}
