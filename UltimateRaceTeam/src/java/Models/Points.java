/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

/**
 *
 * @author Ny Aina Ratolo
 */
public class Points {
    
    private int classement;
    private int point;

    public int getClassement() {
        return classement;
    }

    public void setClassement(int classement) {
        this.classement = classement;
    }

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }

    public Points() {}

    public Points(int classement, int point) {
        this.classement = classement;
        this.point = point;
    }
    
    
    
}
