CREATE TABLE inspection (
    id SERIAL PRIMARY KEY,
    date_debut TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    date_fin TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    vehicule_utilise VARCHAR(100) NOT NULL,
    employe_vehicule VARCHAR(100) NOT NULL,
    kilometrage_debut INTEGER NOT NULL CHECK (kilometrage_debut >= 1 AND kilometrage_debut <= 500000),
    kilometrage_fin INTEGER NOT NULL CHECK (kilometrage_fin >= 1 AND kilometrage_fin <= 500000),
    profileur_laser_utilise VARCHAR(100) NOT NULL,
    employe_profileur_laser VARCHAR(100) NOT NULL,
    voie_routiere_inspectee INTEGER NOT NULL CHECK (voie_routiere_inspectee >= 1), -- pour définir la voie (1 est la voie la plus à droite)
    chemin_fichier_donnees VARCHAR(512) NOT NULL,
    nom_fichier_donnees VARCHAR(18) NOT NULL CHECK (nom_fichier_donnees ~ '^[A-Za-z0-9]{3}_\w{6}-\w{2}\.xdat$')
);
