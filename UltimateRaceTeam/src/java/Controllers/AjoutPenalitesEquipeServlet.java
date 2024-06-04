/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Models.Penalite;
import Utils.ConnectBase;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.Time;

/**
 *
 * @author Ny Aina Ratolo
 */
public class AjoutPenalitesEquipeServlet extends HttpServlet {

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
            out.println("<title>Servlet AjoutPenalitesEquipeServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AjoutPenalitesEquipeServlet at " + request.getContextPath() + "</h1>");
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
        int idEquipe = Integer.parseInt(request.getParameter("idEquipe"));
        String temps = request.getParameter("tempsPenalite");
        
        
        ConnectBase cb = new ConnectBase();
        Connection c = null;
        
        Penalite p = new Penalite();
        
        
        
        try {
            Time time = p.convertStringEnTime(temps);
            c = cb.connectToDataBase();
            p.insertPenaliteEquipe(c, idEtape, idEquipe, time);
            
            response.sendRedirect("FormulaireAjoutPenaliteAdmin.jsp");
            
        } catch (Exception e) {
            request.setAttribute("erreur", e);
            request.getRequestDispatcher("FormulaireAjoutPenaliteAdmin.jsp").forward(request, response);
            
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
