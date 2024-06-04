/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Csv.CsvUtilities;
import Models.EtapeCourse;
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
public class ImportMultipleServlet extends HttpServlet {

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
            out.println("<title>Servlet ImportMultipleServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ImportMultipleServlet at " + request.getContextPath() + "</h1>");
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
        response.setCharacterEncoding("UTF-8");
        Part fileEtape = request.getPart("csvEtape");
        Part fileResultat = request.getPart("csvResultat");

        CsvUtilities csvUtil = new CsvUtilities();
        
        ConnectBase cb = new ConnectBase();
        Connection c = null;
        
        
        try {
            List<CSVRecord> etapeData = csvUtil.getCsvData(fileEtape.getInputStream(), ',');
            List<CSVRecord> resultatData = csvUtil.getCsvData(fileResultat.getInputStream(), ',');
            
            c = cb.connectToDataBase();
            
            ArrayList<EtapeCourse> etpc = csvUtil.listeEtapeCourse(etapeData);
            ArrayList<ResultatCourse> rsc = csvUtil.listeResultatCourse(resultatData);
            
            System.out.println(etpc.size());
            System.out.println(rsc.size());
            csvUtil.insertEtape(c, etpc);
            
            csvUtil.insertResultat(c, rsc);
            
            
            response.sendRedirect("ImportEtapeResultatAdmin.jsp");
        } catch (Exception e) {
            System.out.println("");
            request.setAttribute("erreur", e);
            request.getRequestDispatcher("ImportEtapeResultatAdmin.jsp").forward(request, response);
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
