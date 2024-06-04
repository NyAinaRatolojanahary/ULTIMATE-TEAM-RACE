/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Ny Aina Ratolo
 */
public class ResultatCourse {
    
    private int rangEtape;
    private int numCoureur;
    private String nomCoureur;
    private char genreCoureur;
    private Date dateNaissanceCoureur;
    private String nomEquipe;
    private Timestamp dateHeureArrivee;

    public int getRangEtape() {
        return rangEtape;
    }

    public void setRangEtape(int rangEtape) {
        this.rangEtape = rangEtape;
    }

    public int getNumCoureur() {
        return numCoureur;
    }

    public void setNumCoureur(int numCoureur) {
        this.numCoureur = numCoureur;
    }

    public String getNomCoureur() {
        return nomCoureur;
    }

    public void setNomCoureur(String nomCoureur) {
        this.nomCoureur = nomCoureur;
    }

    public char getGenreCoureur() {
        return genreCoureur;
    }

    public void setGenreCoureur(char genreCoureur) {
        this.genreCoureur = genreCoureur;
    }

    public Date getDateNaissanceCoureur() {
        return dateNaissanceCoureur;
    }

    public void setDateNaissanceCoureur(Date dateNaissanceCoureur) {
        this.dateNaissanceCoureur = dateNaissanceCoureur;
    }
    
    public void setDateNaissanceCoureur(String dateNaissanceCoureur) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        try {
            java.util.Date dtn = dateFormat.parse(dateNaissanceCoureur);
            this.dateNaissanceCoureur = new Date(dtn.getTime());
        } catch (ParseException ex) {
            Logger.getLogger(ResultatCourse.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public String getNomEquipe() {
        return nomEquipe;
    }

    public void setNomEquipe(String nomEquipe) {
        this.nomEquipe = nomEquipe;
    }

    public Timestamp getDateHeureArrivee() {
        return dateHeureArrivee;
    }

    public void setDateHeureArrivee(Timestamp dateHeureArrivee) {
        this.dateHeureArrivee = dateHeureArrivee;
    }

    public ResultatCourse() {}
    
    
    
    public String convertDate(String date){
        SimpleDateFormat formatdateEntree = new SimpleDateFormat("dd/MM/yyyy");
        SimpleDateFormat formatdateSortie = new SimpleDateFormat("yyyy-MM-dd");
        
        java.util.Date dateToFormat = null;
        String formatedDate = null;
        
        try {
            dateToFormat = formatdateEntree.parse(date);
            formatedDate = formatdateSortie.format(dateToFormat);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return formatedDate;
    }
    
    public Timestamp convertStringToTimestamp(String dateString) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        try {
            java.util.Date utilDate = dateFormat.parse(dateString);
            return new Timestamp(utilDate.getTime());
        } catch (ParseException e) {
            e.printStackTrace();
            return null; 
        }
    }
    
}
