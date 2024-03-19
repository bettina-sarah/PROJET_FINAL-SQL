DROP TABLE IF EXISTS Troncon CASCADE;
DROP TABLE IF EXISTS Intersection CASCADE;
DROP TABLE IF EXISTS Reseau_routier CASCADE;
DROP TABLE IF EXISTS liste_reseau_troncon_intersection CASCADE;

DROP TYPE IF EXISTS pavage_enum CASCADE;
DROP SEQUENCE IF EXISTS intersection_identifiant CASCADE;

-- CREATE TABLE AND TYPE Emeric
CREATE TYPE pavage_enum AS ENUM('asphalte','ciment', 'pavé brique', 'pavé pierre');

-- Sequence pour intersection
CREATE SEQUENCE intersection_identifiant
    START WITH 10000
    INCREMENT BY 1
    MINVALUE 10000
    MAXVALUE 99999
    CYCLE;

CREATE TABLE Troncon (
    id              SERIAL PRIMARY KEY,
    nom_rue         VARCHAR(32) NOT NULL,
    longueur        DECIMAL(9,1) NOT NULL CHECK(longueur BETWEEN 0.0 AND 100000.0),
    lim_vitesse     INTEGER NOT NULL CHECK(lim_vitesse BETWEEN 25 AND 120),
    nb_voies        INTEGER  DEFAULT 1 NOT NULL CHECK(nb_voies BETWEEN 1 and 8),
    type_pavage     pavage_enum
);

CREATE TABLE Intersection (
    id              INTEGER DEFAULT nextval('intersection_identifiant') PRIMARY KEY,
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
    intersection_debut_id INTEGER NOT NULL,
    intersection_fin_id INTEGER NOT NULL

);

-- Foreign Keys Emeric
ALTER TABLE liste_reseau_troncon_intersection ADD CONSTRAINT fk_reseau_id_Reseau_routier FOREIGN KEY (reseau_id) REFERENCES Reseau_routier (id);
ALTER TABLE liste_reseau_troncon_intersection ADD CONSTRAINT fk_troncon_id_Reseau_routier FOREIGN KEY (troncon_id) REFERENCES Troncon (id);
ALTER TABLE liste_reseau_troncon_intersection ADD CONSTRAINT fk_intersection_debut_id_Reseau_routier FOREIGN KEY (intersection_debut_id) REFERENCES Intersection (id);
ALTER TABLE liste_reseau_troncon_intersection ADD CONSTRAINT fk_intersection_fin_id_Reseau_routier FOREIGN KEY (intersection_fin_id) REFERENCES Intersection (id);

