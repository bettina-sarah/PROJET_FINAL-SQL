------ EMERIC -------

DROP TABLE IF EXISTS Troncon CASCADE;
DROP TABLE IF EXISTS Intersection CASCADE;
DROP TABLE IF EXISTS Reseau_routier CASCADE;
DROP TABLE IF EXISTS liste_reseau_troncon_intersection CASCADE;

DROP TYPE IF EXISTS pavage_enum;


-- DROP BARIS
DROP TABLE IF EXISTS liste_inspection_info_vehicule CASCADE;
DROP TABLE IF EXISTS Inspection_vehicule CASCADE;
DROP TABLE IF EXISTS Inspection CASCADE;

-- DROP BETTINA

DROP TABLE IF EXISTS Employe CASCADE;
DROP TABLE IF EXISTS Departement CASCADE;
DROP TABLE IF EXISTS Poste CASCADE;
DROP TABLE IF EXISTS Vehicule CASCADE;

DROP TYPE IF EXISTS GENDER;

-- DROP FRANK

DROP TABLE IF EXISTS liste_inspection_troncon CASCADE;
DROP TABLE IF EXISTS liste_inspection_laser  CASCADE;
DROP TABLE IF EXISTS Inspection_laser  CASCADE;
DROP TABLE IF EXISTS Profileur_laser CASCADE;


-- CREATE TABLE AND TYPE Emeric
CREATE TYPE pavage_enum AS ENUM('asphalte','ciment', 'pavé brique', 'pavé pierre');

CREATE TABLE Troncon (
    id              SERIAL PRIMARY KEY,
    nom_rue         VARCHAR(32) NOT NULL,
    longueur        DECIMAL(9,1) NOT NULL CHECK(longueur BETWEEN 0.0 AND 100000.0),
    lim_vitesse     INTEGER NOT NULL CHECK(lim_vitesse BETWEEN 25 AND 120),
    nb_voies        INTEGER  DEFAULT 1 NOT NULL CHECK(nb_voies BETWEEN 1 and 8),
    type_pavage     pavage_enum
);

CREATE TABLE Intersection (
    id              INTEGER PRIMARY KEY CHECK(id BETWEEN 10000 AND 99999),
    latitude        DECIMAL(8,6) NOT NULL,
    longitude       DECIMAL(8,6) NOT NULL,
    type_pavage     pavage_enum
);

CREATE TABLE Reseau_routier(
    id              SERIAL PRIMARY KEY,
    nom             VARCHAR(32) NOT NULL
);

CREATE TABLE liste_reseau_troncon_intersection(
    id              SERIAL PRIMARY KEY,
    reseau_id       INTEGER NOT NULL,
    troncon_id      INTEGER NOT NULL,
    intersection_id INTEGER NOT NULL
);


-- ************************************* FRANK *****************************************************


CREATE TABLE Profileur_laser(
    num_serie   CHAR(16)  PRIMARY KEY,
    marque      VARCHAR(32)  NOT NULL,
    modele      VARCHAR(32)  NOT NULL
);

CREATE TABLE Inspection_laser(
    id                      SERIAL      PRIMARY KEY,
    inspection_id           INTEGER      NOT NULL,
    employe_id              INTEGER      NOT NULL,
    profileur_laser_id      CHAR(16)    NOT NULL      
);

-- CREATE TABLE liste_inspection_laser(
--     id                      SERIAL      PRIMARY KEY,
    
--     inpsection_laser_id     INTEGER      NOT NULL      
-- );

CREATE TABLE liste_inspection_troncon(
    id                      SERIAL      PRIMARY KEY,
    inspection_id           INTEGER      NOT NULL,
    troncon_id              INTEGER      NOT NULL,
    voie                    INTEGER     NOT NULL      
);



----------------- BETTINA ---------------------------

-- ************ CREATE tables BETTINA *************
 

CREATE TYPE GENDER AS ENUM
                        ('f','h','x');
						
						
-- tableau de reference
CREATE TABLE Departement (
	departement_id			SERIAL			PRIMARY KEY,
	departement_nom			VARCHAR(64)		NOT NULL
);

-- tableau de reference
CREATE TABLE Poste (
	poste_id		SERIAL			PRIMARY KEY,
	poste_nom		VARCHAR(64)		NOT NULL
);


CREATE TABLE Employe (
	id					SERIAL					PRIMARY KEY,
	nom					VARCHAR(32)				NOT NULL,
	prenom				VARCHAR(32)				NOT NULL,
	genre				GENDER					NOT NULL,
	nas					CHAR(9)					NOT NULL,
	date_embauche		DATE					DEFAULT CURRENT_DATE,
	salaire_horaire		NUMERIC(5,2)			DEFAULT 27.50,
	poste				VARCHAR(64)				NOT NULL,
	departement			VARCHAR(64)				NOT NULL,
	
	CONSTRAINT contr_embauche CHECK (date_embauche BETWEEN '2018-01-01' AND CURRENT_DATE),
	CONSTRAINT contr_salaire CHECK (salaire_horaire BETWEEN 15.00 AND 250.00)
-- 	CONSTRAINT contr_poste CHECK (poste IN (SELECT poste_nom FROM Poste)),
-- 	CONSTRAINT contr_dept CHECK (departement IN (SELECT departement_nom FROM Departement))
);
									 
									 
CREATE TABLE Vehicule (
	immatriculation			CHAR(6)		PRIMARY KEY,
	marque					VARCHAR(32)		NOT NULL,
	modele					VARCHAR(32)		NOT NULL
);					 




------------------ BARIS ----------------------


-- Création de la table Inspection_vehicule
CREATE TABLE Inspection_vehicule (
    id SERIAL PRIMARY KEY,
    inspection_id           INTEGER      NOT NULL,
    vehicule_id CHAR(6)		NOT NULL,
	employe_id INTEGER	NOT NULL,
    kilometrage_debut DECIMAL(8,2) NOT NULL,
    kilometrage_fin DECIMAL(8,2) NOT NULL,
	
	CONSTRAINT contr_km_debut CHECK (kilometrage_debut >= 1 AND kilometrage_debut <= 500000),
	CONSTRAINT contr_km_fin CHECK (kilometrage_fin >= 1 AND kilometrage_fin <= 500000)
);

-- Création de la table Inspection
CREATE TABLE Inspection (
    id SERIAL PRIMARY KEY,
    date_debut TIMESTAMP NOT NULL,
    date_fin TIMESTAMP NOT NULL,
    chemin_fichier_donnees VARCHAR(512) NOT NULL,
    nom_fichier_donnees CHAR(18) NOT NULL,
	
	CONSTRAINT contr_nom_fichier CHECK (nom_fichier_donnees ~ '^PZW_[A-Z]{3}\d{3}-\d{2}\.xdat$')
	-- ~ signale que le string suivant est du regex; ^ et $ debut et fin
);

-- Création de la table liste_inspection_info_vehicule
-- CREATE TABLE liste_inspection_info_vehicule (
--     id SERIAL PRIMARY KEY,
--     inspection_id INTEGER	NOT NULL,
--     inspection_vehicule_id INTEGER		NOT NULL
-- );






-- *************** FOREIGN KEYS ***************************

-- Foreign Keys Emeric
ALTER TABLE liste_reseau_troncon_intersection ADD CONSTRAINT fk_reseau_id_Reseau_routier FOREIGN KEY (reseau_id) REFERENCES Reseau_routier (id);
ALTER TABLE liste_reseau_troncon_intersection ADD CONSTRAINT fk_troncon_id_Reseau_routier FOREIGN KEY (troncon_id) REFERENCES Troncon (id);
ALTER TABLE liste_reseau_troncon_intersection ADD CONSTRAINT fk_intersection_id_Reseau_routier FOREIGN KEY (intersection_id) REFERENCES Intersection (id);


-- FK FRANK 

ALTER TABLE IF EXISTS liste_inspection_troncon DROP CONSTRAINT IF EXISTS fk_inspection_id__inspection;
ALTER TABLE IF EXISTS liste_inspection_troncon DROP CONSTRAINT IF EXISTS fk_troncon_id__troncon;
ALTER TABLE IF EXISTS Inspection_laser DROP CONSTRAINT IF EXISTS fk_inspection_id__inspection;
-- ALTER TABLE IF EXISTS liste_inspection_laser DROP CONSTRAINT IF EXISTS fk_inpsection_laser_id__Inspection_laser;
ALTER TABLE IF EXISTS Inspection_laser DROP CONSTRAINT IF EXISTS fk_employe_id__employe;
ALTER TABLE IF EXISTS Inspection_laser DROP CONSTRAINT IF EXISTS fk_profileur_laser_id__Inspection_laser;

ALTER TABLE Inspection_laser
    ADD CONSTRAINT fk_inspection_id__inspection FOREIGN KEY (inspection_id) REFERENCES Inspection(id),
	ADD CONSTRAINT fk_employe_id__employe FOREIGN KEY (employe_id) REFERENCES employe(id),
	ADD CONSTRAINT fk_profileur_laser_id__Profileur_laser FOREIGN KEY (profileur_laser_id) REFERENCES Profileur_laser(num_serie);


ALTER TABLE liste_inspection_troncon
	ADD CONSTRAINT fk_inspection_id__inspection FOREIGN KEY (inspection_id) REFERENCES Inspection(id),
	ADD CONSTRAINT fk_troncon_id__troncon FOREIGN KEY (troncon_id) REFERENCES troncon(id);


-- FK "BARIS"


ALTER TABLE inspection_vehicule
ADD CONSTRAINT fk_inspection_id__inspection FOREIGN KEY (inspection_id) REFERENCES Inspection(id),
ADD CONSTRAINT fk_vehicule_id__vehicule FOREIGN KEY (vehicule_id) REFERENCES vehicule(immatriculation),
ADD CONSTRAINT fk_employe_id__employe FOREIGN KEY (employe_id) REFERENCES employe(id);




