-- ************ CREATE tables BETTINA *************
 
DROP TABLE IF EXISTS Employe CASCADE;
DROP TABLE IF EXISTS Departement CASCADE;
DROP TABLE IF EXISTS Poste CASCADE;
DROP TABLE IF EXISTS Vehicule CASCADE;

DROP TYPE IF EXISTS genre_employe;
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
	post_nom		VARCHAR(64)		NOT NULL
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