/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Csv.CsvUtilities;
import Models.EtapeCourse;
import Models.Points;
import Models.ResultatCourse;
import Utils.ConnectBase;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.csv.CSVRecord;

/**
 *
 * @author Ny Aina Ratolo
 */
@MultipartConfig
public class ImportPointsServlet extends HttpServlet {

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
            out.println("<title>Servlet ImportPointsServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ImportPointsServlet at " + request.getContextPath() + "</h1>");
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
        Part filePoint = request.getPart("csvPoints");

        CsvUtilities csvUtil = new CsvUtilities();
        
        ConnectBase cb = new ConnectBase();
        Connection c = null;
        
        
        try {
            List<CSVRecord> pointData = csvUtil.getCsvData(filePoint.getInputStream(), ',');
            
            c = cb.connectToDataBase();
            
            ArrayList<Points> etpc = csvUtil.listePoint(pointData);
            

            csvUtil.insertPoints(c, etpc);
            
            
            response.sendRedirect("ImportPointsAdmin.jsp");
        } catch (Exception e) {
            System.out.println("");
            request.setAttribute("erreur", e);
            request.getRequestDispatcher("ImportPointsAdmin.jsp").forward(request, response);
        }
        finally{
            try {
                c.close();
            } catch (SQLException ex) {
                Logger.getLogger(ImportMultipleServlet.class.getName()).log(Level.SEVERE, null, ex);
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
