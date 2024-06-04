/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Models.CoureurEtape;
import Utils.ConnectBase;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Ny Aina Ratolo
 */
public class AjouterTempsCoureurEtapeServlet extends HttpServlet {

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
            out.println("<title>Servlet AjouterTempsCoureurEtapeServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AjouterTempsCoureurEtapeServlet at " + request.getContextPath() + "</h1>");
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
        String[] idCoureur = request.getParameterValues("idCoureur[]");
        String[] temps = request.getParameterValues("temps[]");
        
        ConnectBase cb = new ConnectBase();
        Connection c = null;
        
        try {
            CoureurEtape cr = new CoureurEtape();
            
            c = cb.connectToDataBase();
            
            for (int i = 0; i < idCoureur.length; i++) {
                cr.setIdEtape(idEtape);
                cr.setIdCoureur(Integer.parseInt(idCoureur[i]));
                cr.setDateHeureArrivee(temps[i]);
                cr.InsertTempsCoureur(c, cr.getIdEtape(), cr.getIdCoureur(), cr.getDateHeureArrivee());
            }
            
            response.sendRedirect("ListeEtapeCourseAdmin.jsp");
            
        } catch (Exception e) {
            request.setAttribute("erreur", e);
            request.setAttribute("idEtape", idEtape);
            request.getRequestDispatcher("FormulaireAffectationHeureCoureurAdmin.jsp").forward(request, response);
        }
        finally{
            try {
                c.close();
            } catch (SQLException ex) {
                Logger.getLogger(AjouterTempsCoureurEtapeServlet.class.getName()).log(Level.SEVERE, null, ex);
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
