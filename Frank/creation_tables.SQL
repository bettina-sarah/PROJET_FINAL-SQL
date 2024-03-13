-- ************************************* FRANK *****************************************************
DROP TABLE IF EXISTS liste_inspection_troncon CASCADE;
DROP TABLE IF EXISTS liste_inspection_laser  CASCADE;
DROP TABLE IF EXISTS Inspection_laser  CASCADE;
DROP TABLE IF EXISTS Profileur_laser CASCADE;

-- SEULEMENT POUR FAIRE DES TESTES:
-- DROP TABLE IF EXISTS Employe CASCADE;
-- DROP TABLE IF EXISTS Inspection CASCADE;
-- DROP TABLE IF EXISTS Troncon CASCADE;

-- CREATE TABLE Employe(
--     id   SERIAL  PRIMARY KEY
-- );

-- CREATE TABLE Inspection(
--     id   SERIAL  PRIMARY KEY
-- );

-- CREATE TABLE Troncon(
--     id   SERIAL  PRIMARY KEY
-- );

CREATE TABLE Profileur_laser(
    num_serie   CHAR(16)  PRIMARY KEY,
    marque      VARCHAR(32)  NOT NULL,
    modele      VARCHAR(32)  NOT NULL
);

CREATE TABLE Inspection_laser(
    id                      SERIAL      PRIMARY KEY,
    employe_id              SERIAL      NOT NULL,
    profileur_laser_id      CHAR(16)    NOT NULL      
);

CREATE TABLE liste_inspection_laser(
    id                      SERIAL      PRIMARY KEY,
    inspection_id           SERIAL      NOT NULL,
    inpsection_laser_id     SERIAL      NOT NULL      
);

CREATE TABLE liste_inspection_troncon(
    id                      SERIAL      PRIMARY KEY,
    inspection_id           SERIAL      NOT NULL,
    troncon_id              SERIAL      NOT NULL,
    voie                    INTEGER     NOT NULL      
);

ALTER TABLE IF EXISTS liste_inspection_troncon DROP CONSTRAINT IF EXISTS fk_inspection_id__inspection;
ALTER TABLE IF EXISTS liste_inspection_troncon DROP CONSTRAINT IF EXISTS fk_troncon_id__troncon;
ALTER TABLE IF EXISTS liste_inspection_laser DROP CONSTRAINT IF EXISTS fk_inspection_id__inspection;
ALTER TABLE IF EXISTS liste_inspection_laser DROP CONSTRAINT IF EXISTS fk_inpsection_laser_id__Inspection_laser;
ALTER TABLE IF EXISTS Inspection_laser DROP CONSTRAINT IF EXISTS fk_employe_id__employe;
ALTER TABLE IF EXISTS Inspection_laser DROP CONSTRAINT IF EXISTS fk_profileur_laser_id__Inspection_laser;

ALTER TABLE Inspection_laser
	ADD CONSTRAINT fk_employe_id__employe FOREIGN KEY (employe_id) REFERENCES employe(id),
	ADD CONSTRAINT fk_profileur_laser_id__Profileur_laser FOREIGN KEY (profileur_laser_id) REFERENCES Profileur_laser(num_serie);

ALTER TABLE liste_inspection_laser
	ADD CONSTRAINT fk_inspection_id__inspection FOREIGN KEY (inspection_id) REFERENCES Inspection(id),
	ADD CONSTRAINT fk_inpsection_laser_id__Inspection_laser FOREIGN KEY (inpsection_laser_id) REFERENCES Inspection_laser(id);

ALTER TABLE liste_inspection_troncon
	ADD CONSTRAINT fk_inspection_id__inspection FOREIGN KEY (inspection_id) REFERENCES Inspection(id),
	ADD CONSTRAINT fk_troncon_id__troncon FOREIGN KEY (troncon_id) REFERENCES troncon(id);





