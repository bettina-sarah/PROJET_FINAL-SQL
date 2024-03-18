-- Suppression des tables si elles existent déjà
DROP TABLE IF EXISTS liste_inspection_info_vehicule;
DROP TABLE IF EXISTS Inspection_vehicule;
DROP TABLE IF EXISTS Inspection;

-- Création de la table Inspection_vehicule
CREATE TABLE Inspection_vehicule (
    id SERIAL PRIMARY KEY,
    inspection_id INTEGER REFERENCES Inspection(id),
    vehicule_id INTEGER,
    kilometrage_debut DECIMAL(8,2) NOT NULL,
    kilometrage_fin DECIMAL(8,2) NOT NULL
);

-- Création de la table Inspection
CREATE TABLE Inspection (
    id SERIAL PRIMARY KEY,
    date_debut TIMESTAMP NOT NULL,
    date_fin TIMESTAMP NOT NULL,
    chemin_fichier_donnees VARCHAR(512) NOT NULL,
    nom_fichier_donnees VARCHAR(18) NOT NULL
);

-- Création de la table liste_inspection_info_vehicule
CREATE TABLE liste_inspection_info_vehicule (
    id SERIAL PRIMARY KEY,
    inspection_id INTEGER REFERENCES Inspection(id),
    inspection_vehicule_id INTEGER REFERENCES Inspection_vehicule(id)
);
