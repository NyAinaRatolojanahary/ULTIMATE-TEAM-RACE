INSERT INTO Course (NomCourse) values ('Trail RN4');

INSERT INTO Etape (NomEtape,Longueur,NbrCoureurEquipe,DateHeureDepart,idCourse) values ('Andohatapenaka-Ambohidratrimo',20.5,4,'2024-06-01 08:00:00',1);
INSERT INTO Etape (NomEtape,Longueur,NbrCoureurEquipe,DateHeureDepart,idCourse) values ('Ambohidratrimo-Mahintsy',12.3,2,'2024-06-01 13:00:00',1);
INSERT INTO Etape (NomEtape,Longueur,NbrCoureurEquipe,DateHeureDepart,idCourse) values ('Mahintsy-Ankazobe',30.8,4,'2024-06-02 08:00:00',1);
INSERT INTO Etape (NomEtape,Longueur,NbrCoureurEquipe,DateHeureDepart,idCourse) values ('Ankazobe-Mahintsy',30.8,3,'2024-06-01 14:00:00',1);

INSERT INTO Equipe (NomEquipe,mail,pwd) values ('TrailXp','trailxp@gmail.com','trailxp');
INSERT INTO Equipe (NomEquipe,mail,pwd) values ('Kotrana Club','kotrana@gmail.com','kotrana');
INSERT INTO Equipe (NomEquipe,mail,pwd) values ('Lomay','lomay@gmail.com','lomay');
INSERT INTO Equipe (NomEquipe,mail,pwd) values ('Vikina','Vikina@gmail.com','vikina');

INSERT INTO Admin (mail,pwd) values ('admin@gmail.com','admin');

INSERT INTO Coureur (NomCoureur,Numero,Genre,DateNaissance,idEquipe) values ('Matio',10,1,'1989-10-23',1);
INSERT INTO Coureur (NomCoureur,Numero,Genre,DateNaissance,idEquipe) values ('Maria',7,0,'1990-01-18',1);
INSERT INTO Coureur (NomCoureur,Numero,Genre,DateNaissance,idEquipe) values ('Marka',18,1,'1989-09-15',1);
INSERT INTO Coureur (NomCoureur,Numero,Genre,DateNaissance,idEquipe) values ('Paoly',5,1,'1989-10-23',1);

INSERT INTO Coureur (NomCoureur,Numero,Genre,DateNaissance,idEquipe) values ('Lioka',3,1,'1989-10-23',2);
INSERT INTO Coureur (NomCoureur,Numero,Genre,DateNaissance,idEquipe) values ('Matia',8,1,'1990-01-18',2);
INSERT INTO Coureur (NomCoureur,Numero,Genre,DateNaissance,idEquipe) values ('Magdalena',12,0,'1989-09-15',2);
INSERT INTO Coureur (NomCoureur,Numero,Genre,DateNaissance,idEquipe) values ('Josefa',9,1,'1989-10-23',2);

INSERT INTO Coureur (NomCoureur,Numero,Genre,DateNaissance,idEquipe) values ('Jakoba',15,1,'1989-10-23',3);
INSERT INTO Coureur (NomCoureur,Numero,Genre,DateNaissance,idEquipe) values ('Joda',2,1,'1990-01-18',3);
INSERT INTO Coureur (NomCoureur,Numero,Genre,DateNaissance,idEquipe) values ('Benjamina',1,1,'1989-09-15',3);
INSERT INTO Coureur (NomCoureur,Numero,Genre,DateNaissance,idEquipe) values ('Sarah',4,0,'1989-10-23',3);

INSERT INTO Coureur (NomCoureur,Numero,Genre,DateNaissance,idEquipe) values ('Tomasy',11,1,'1989-10-23',4);
INSERT INTO Coureur (NomCoureur,Numero,Genre,DateNaissance,idEquipe) values ('Petera',6,1,'1990-01-18',4);
INSERT INTO Coureur (NomCoureur,Numero,Genre,DateNaissance,idEquipe) values ('Jodasy',20,1,'1989-09-15',4);
INSERT INTO Coureur (NomCoureur,Numero,Genre,DateNaissance,idEquipe) values ('Rota',14,0,'1989-10-23',4);


INSERT INTO Categorie (NomCategorie) values ('Homme');
INSERT INTO Categorie (NomCategorie) values ('Femme');
INSERT INTO Categorie (NomCategorie) values ('Junior');
INSERT INTO Categorie (NomCategorie) values ('Senior');

INSERT INTO CategorieCoureur (idCoureur,idCategorie) values (1,1);
INSERT INTO CategorieCoureur (idCoureur,idCategorie) values (2,2);
INSERT INTO CategorieCoureur (idCoureur,idCategorie) values (3,1);
INSERT INTO CategorieCoureur (idCoureur,idCategorie) values (4,1);
INSERT INTO CategorieCoureur (idCoureur,idCategorie) values (5,1);
INSERT INTO CategorieCoureur (idCoureur,idCategorie) values (6,1);
INSERT INTO CategorieCoureur (idCoureur,idCategorie) values (7,2);
INSERT INTO CategorieCoureur (idCoureur,idCategorie) values (8,1);
INSERT INTO CategorieCoureur (idCoureur,idCategorie) values (9,1);
INSERT INTO CategorieCoureur (idCoureur,idCategorie) values (10,1);
INSERT INTO CategorieCoureur (idCoureur,idCategorie) values (11,1);
INSERT INTO CategorieCoureur (idCoureur,idCategorie) values (12,2);
INSERT INTO CategorieCoureur (idCoureur,idCategorie) values (13,1);
INSERT INTO CategorieCoureur (idCoureur,idCategorie) values (14,1);
INSERT INTO CategorieCoureur (idCoureur,idCategorie) values (15,1);
INSERT INTO CategorieCoureur (idCoureur,idCategorie) values (16,2);

INSERT INTO PointRang (Classement,Points) values (1,10);
INSERT INTO PointRang (Classement,Points) values (2,6);
INSERT INTO PointRang (Classement,Points) values (3,4);
INSERT INTO PointRang (Classement,Points) values (4,2);
INSERT INTO PointRang (Classement,Points) values (5,1);