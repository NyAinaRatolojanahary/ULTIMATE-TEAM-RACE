CREATE DATABASE trail;

\c trail

CREATE TABLE Course(
   idCourse SERIAL,
   NomCourse VARCHAR(255)  NOT NULL,
   PRIMARY KEY(idCourse)
);

CREATE TABLE Admin(
   idAdmin SERIAL,
   mail VARCHAR(255)  NOT NULL,
   pwd VARCHAR(255)  NOT NULL,
   PRIMARY KEY(idAdmin)
);

CREATE TABLE Etape(
   idEtape SERIAL,
   NomEtape VARCHAR(255)  NOT NULL,
   Longueur DECIMAL(18,2)   NOT NULL,
   NbrCoureurEquipe INTEGER NOT NULL,
   DateHeureDepart TIMESTAMP NOT NULL,
   idCourse INTEGER NOT NULL,
   PRIMARY KEY(idEtape),
   FOREIGN KEY(idCourse) REFERENCES Course(idCourse)
);

CREATE TABLE Equipe(
   idEquipe SERIAL,
   NomEquipe VARCHAR(255)  NOT NULL,
   mail VARCHAR(255)  NOT NULL,
   pwd VARCHAR(255)  NOT NULL,
   PRIMARY KEY(idEquipe)
);

CREATE TABLE Coureur(
   idCoureur SERIAL,
   NomCoureur VARCHAR(255)  NOT NULL,
   Numero INTEGER NOT NULL,
   Genre INTEGER NOT NULL,
   DateNaissance DATE NOT NULL,
   idEquipe INTEGER NOT NULL,
   PRIMARY KEY(idCoureur),
   UNIQUE(Numero),
   FOREIGN KEY(idEquipe) REFERENCES Equipe(idEquipe)
);

CREATE TABLE Categorie(
   idCategorie SERIAL,
   NomCategorie VARCHAR(255)  NOT NULL,
   PRIMARY KEY(idCategorie)
);

CREATE TABLE CategorieCoureur(
   idCoureur INTEGER,
   idCategorie INTEGER,
   PRIMARY KEY(idCoureur, idCategorie),
   FOREIGN KEY(idCoureur) REFERENCES Coureur(idCoureur),
   FOREIGN KEY(idCategorie) REFERENCES Categorie(idCategorie)
);

CREATE TABLE CoureurEtape(
   idEtape INTEGER,
   idCoureur INTEGER,
   DateHeureArrivee TIMESTAMP,
   PRIMARY KEY(idEtape, idCoureur),
   FOREIGN KEY(idEtape) REFERENCES Etape(idEtape),
   FOREIGN KEY(idCoureur) REFERENCES Coureur(idCoureur)
);

CREATE TABLE PointRang(
   idRang SERIAL,
   Classement INTEGER NOT NULL,
   Points INTEGER NOT NULL,
   PRIMARY KEY(idRang)
);

-- Debut 03/06/24
ALTER TABLE Etape drop column idCourse CASCADE;
ALTER TABLE Etape add column rang int UNIQUE;

ALTER TABLE Coureur drop column genre;
ALTER TABLE Coureur add column genre char(1);

ALTER TABLE Equipe ADD CONSTRAINT uniqueNomEquipe UNIQUE (NomEquipe);