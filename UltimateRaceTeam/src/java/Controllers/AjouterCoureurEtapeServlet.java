/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Models.Coureur;
import Models.CoureurEtape;
import Models.Equipe;
import Utils.ConnectBase;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
public class AjouterCoureurEtapeServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AjouterCoureurEtapeServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AjouterCoureurEtapeServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int idEtape = Integer.parseInt(request.getParameter("idEtape"));
        String[] idCoureur = request.getParameterValues("coureur[]");
        
        HttpSession sess = request.getSession();
    
        Equipe e = new Equipe();
        e = (Equipe)sess.getAttribute("equipe");
        int idEquipe = e.getIdequipe();
        
        ConnectBase cb = new ConnectBase();
        Connection c = null; 
        Statement st = null;
        ResultSet rs = null;
        
        String sql1 = "SELECT * FROM v_nbrCoureurAutoriseEtape WHERE idEtape="+idEtape+";";
        String sql2 = "SELECT * FROM v_nbrCoureurAssignerEtape WHERE idEtape="+idEtape+" AND idEquipe="+idEquipe+";";
        
        int nbrCoureurAutoriseEtape = 0;
        int nbrCoureurAssignerEtape = 0;
        
        try {
            c = cb.connectToDataBase();
            st = c.createStatement();
            rs = st.executeQuery(sql1);
            
            while (rs.next()) {
                nbrCoureurAutoriseEtape = rs.getInt("nbrcoureurequipe");
            }
            
            rs = st.executeQuery(sql2);
            
            while (rs.next()) {
                nbrCoureurAssignerEtape = rs.getInt("count");
            }
            
            int reste = nbrCoureurAutoriseEtape - nbrCoureurAssignerEtape;
            
            if(reste>0){
                
                CoureurEtape ce = new CoureurEtape();
        
                try {
                    for(int i=0; i<reste; i++){
                        ce.ajouterCoureurEtape(idEtape, Integer.parseInt(idCoureur[i]));
                    }   

                    Coureur cr = new Coureur();
                    ArrayList<Coureur> lscr = new ArrayList<>();

                    request.setAttribute("idEtape", idEtape);
                    request.setAttribute("listeCoureur", lscr);
                    request.setAttribute("nombreCoureur", idCoureur.length);
                    request.getRequestDispatcher("FormulaireAffectationCoureurEquipe.jsp").forward(request, response);
                } catch (Exception ex) {

                    Coureur cr = new Coureur();
                    ArrayList<Coureur> lscr = new ArrayList<>();
                    try {
                        lscr = cr.getAllCoureurByIdEquipe(null,idEquipe);

                        request.setAttribute("idEtape", idEtape);
                        request.setAttribute("listeCoureur", lscr);
                        request.setAttribute("nombreCoureur", idCoureur.length);
                        request.setAttribute("erreur", e);
                        RequestDispatcher disp = request.getRequestDispatcher("FormulaireAffectationCoureurEquipe.jsp");
                        disp.forward(request, response);
                    } catch (Exception exc) {
                        response.sendRedirect("ListeEtapeCourseEquipe.jsp");
                    }
                }

            }
            else{
                Exception exc = new Exception("Vous avez deja atteint le quotat de joueur pour cette Etape");
                
                try {
                
                Coureur cr = new Coureur();
                ArrayList<Coureur> lscr = new ArrayList<>();
                lscr = cr.getAllCoureurByIdEquipe(null,idEquipe);
                request.setAttribute("idEtape", idEtape);
                request.setAttribute("listeCoureur", lscr);
                request.setAttribute("nombreCoureur", idCoureur.length);
                request.setAttribute("erreur", exc);
                RequestDispatcher disp = request.getRequestDispatcher("FormulaireAffectationCoureurEquipe.jsp");
                disp.forward(request, response);
            } catch (Exception ex) {
                Logger.getLogger(AjouterCoureurEtapeServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            }
            
        } catch (Exception exp) {
            try {
                
                Coureur cr = new Coureur();
                ArrayList<Coureur> lscr = new ArrayList<>();
                lscr = cr.getAllCoureurByIdEquipe(null,idEquipe);
                request.setAttribute("idEtape", idEtape);
                request.setAttribute("listeCoureur", lscr);
                request.setAttribute("nombreCoureur", idCoureur.length);
                request.setAttribute("erreur", new Exception("Vous avez deja atteint le queotat"));
                RequestDispatcher disp = request.getRequestDispatcher("FormulaireAffectationCoureurEquipe.jsp");
                disp.forward(request, response);
            } catch (Exception ex) {
                Logger.getLogger(AjouterCoureurEtapeServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
