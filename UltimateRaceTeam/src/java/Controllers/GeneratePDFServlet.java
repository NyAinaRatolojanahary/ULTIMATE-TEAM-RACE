/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Models.ClassementGeneral;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import com.itextpdf.text.*;

/**
 *
 * @author Ny Aina Ratolo
 */
public class GeneratePDFServlet extends HttpServlet {

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
            out.println("<title>Servlet GeneratePDFServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GeneratePDFServlet at " + request.getContextPath() + "</h1>");
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
        ArrayList<ClassementGeneral> lsclass = (ArrayList<ClassementGeneral>) request.getAttribute("listeGagnant");

        try {
            
            // Set the document to landscape
            Document document = new Document(PageSize.A4.rotate());
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            PdfWriter.getInstance(document, baos);
            document.open();
            
            BaseColor titleColor = new BaseColor(255, 215, 0);
            BaseColor fontColor = new BaseColor(119, 136, 153);
            BaseColor rankColor = new BaseColor(165, 42, 42);
            BaseColor pointColor = new BaseColor(68, 108, 162);

            // Define fonts
            Font titleFont = new Font(Font.FontFamily.TIMES_ROMAN, 70, Font.BOLD, titleColor);
            Font bodyFont = new Font(Font.FontFamily.HELVETICA, 60, Font.BOLD, fontColor);
            Font textFont = new Font(Font.FontFamily.TIMES_ROMAN, 30, Font.UNDEFINED);
            Font rankFont = new Font(Font.FontFamily.HELVETICA, 30, Font.NORMAL,rankColor);
            Font pointFont = new Font(Font.FontFamily.HELVETICA, 30, Font.NORMAL,pointColor);

            for (ClassementGeneral team : lsclass) {
                // Background image
                Image bgImage = Image.getInstance(getServletContext().getRealPath("/img/Bordure.png"));
                bgImage.setAbsolutePosition(0, 0);
                bgImage.scaleToFit(document.getPageSize().getWidth(), document.getPageSize().getHeight());
                document.add(bgImage);

                // Title
                Paragraph title = new Paragraph("CHAMPION", titleFont);
                title.setAlignment(Element.ALIGN_CENTER);
                document.add(title);

                document.add(new Paragraph(" "));
                document.add(new Paragraph(" "));
                document.add(new Paragraph(" "));
                document.add(new Paragraph(" "));
                
                // Text
                Paragraph text = new Paragraph("Pour votre participation à Ultimate Race Team, nous vous décernons ce certificat en guise de félicitations.", textFont);
                text.setAlignment(Element.ALIGN_CENTER);
                document.add(text);
                
                // Team Name
                Paragraph teamName = new Paragraph("Equipe "+team.getNomEquipe(), bodyFont);
                teamName.setAlignment(Element.ALIGN_CENTER);
                document.add(teamName);
                
                

                

                // Rank
                Paragraph rank = new Paragraph("RANG: " + team.getRang(), rankFont);
                rank.setAlignment(Element.ALIGN_CENTER);
                document.add(rank);

                // Points
                Paragraph points = new Paragraph("Points: " + team.getPoint(), pointFont);
                points.setAlignment(Element.ALIGN_CENTER);
                document.add(points);

                // Add a new page for each team
                if (!team.equals(lsclass.get(lsclass.size() - 1))) {
                    document.newPage();
                }
            }

            document.close();

            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=Certificate.pdf");
            response.setContentLength(baos.size());

            baos.writeTo(response.getOutputStream());
            response.getOutputStream().flush();
        } catch (DocumentException | IOException e) {
            throw new IOException(e.getMessage());
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
