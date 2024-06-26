-- ************ INSERT BETTINA: poste, departement, employe

-- *** POSTE:

INSERT INTO poste (poste_nom)
	VALUES 	('professionnel'),
	 		('technicien'),
			('ingénieur'),
			('scientifique'),
			('manutentionnaire'),
			('soutient');

-- -- *** DEPARTEMENT:

INSERT INTO departement (departement_nom)
	VALUES	('administration'),
			('ventes et représentation'),
			('achats'),
			('mécanique'),
			('électrique'),
			('informatique'),
			('recherche');

--------- ******************* Création TRIGGERS & FONCTIONS pour les inserts employé

--Créer fonction pour le trigger du poste:
CREATE OR REPLACE FUNCTION fonction_poste() RETURNS TRIGGER
LANGUAGE PLPGSQL AS $$
BEGIN
IF NEW.poste NOT IN (SELECT poste_nom FROM poste) THEN
        RAISE EXCEPTION 'Poste n"existe pas';
    END IF;
    RETURN NEW;
END;
$$;

-- Créer TRIGGER pour AVANT l'insertion du poste dans employe
CREATE TRIGGER trigger_poste
	BEFORE INSERT
	ON employe
	FOR EACH ROW
	EXECUTE FUNCTION fonction_poste();
	

--Créer fonction pour le trigger du departement:
CREATE OR REPLACE FUNCTION fonction_departement() RETURNS TRIGGER
LANGUAGE PLPGSQL AS $$
BEGIN
IF NEW.departement NOT IN (SELECT departement_nom FROM departement) THEN
        RAISE EXCEPTION 'Departement n"existe pas!';
    END IF;
    RETURN NEW;
END;
$$;

-- Créer TRIGGER pour AVANT l'insertion du departement dans employe
CREATE TRIGGER trigger_departement
	BEFORE INSERT
	ON employe
	FOR EACH ROW
	EXECUTE FUNCTION fonction_departement();


-- *** INSERTS EMPLOYE:

INSERT INTO employe (nom, prenom, genre, nas, date_embauche, salaire_horaire, poste, departement)
	VALUES	('Couronne', 'Veruce', 'x', 666666666, '2020-03-01', 250.00, 'scientifique', 'recherche'),
	 		('Lebel', 'Veronique', 'f', 888444222, '2022-04-02', 100.50, 'ingénieur', 'mécanique'),
			('LeGrand', 'Chad', 'h', 111222333, CURRENT_DATE, 15.00, 'soutient', 'ventes et représentation');

--salaire: defaut
INSERT INTO employe (nom, prenom, genre, nas, date_embauche, poste, departement) 
	VALUES 	('Banane', 'Jean', 'h', 123456789, '2018-05-20', 'professionnel', 'achats'),
			('Jesus', 'Marie', 'f', 555999777, '2018-12-24', 'manutentionnaire', 'administration');

---------------------------- EMERIC
INSERT INTO Troncon (nom_rue, longueur, lim_vitesse, nb_voies, type_pavage)
    VALUES  ('Viau',750.0, 40, 2, 'asphalte'),
            ('Viau', 1000.0, 40, 2, 'asphalte'),
            ('Rosemont', 1100.0, 50, 2, 'asphalte');
        


INSERT INTO Intersection (latitude, longitude, type_pavage )
    VALUES (45.562518, -73.546013, 'asphalte'), -- viau/PC
            (45.565307, -73.554358, 'asphalte'), -- viau/sherb
            (45.569234, -73.566277, 'asphalte'), -- viau/rosemont
            (45.560802, -73.573757, 'asphalte'); -- rosemont/pieIX


INSERT INTO Reseau_routier (nom)
    VALUES ('Parc Maisonneuve');

INSERT INTO liste_reseau_troncon_intersection (reseau_id, troncon_id, intersection_debut_id, intersection_fin_id)
    VALUES (1, 1, 10000, 10001 ),
            (1, 1, 10001, 10000),
            (1, 2, 10001, 10002),
            (1, 2, 10002, 10001),
            (1, 3, 10002, 10003),
            (1, 3, 10003, 10002);

-- INSERT FRANK

INSERT INTO Profileur_laser (num_serie, marque, modele)
    VALUES  ('POW-PEW-13212','POWERMAN','FULLPEW'),
            ('POW-PEW-44312','POWERMAN','FULLPEW'),
            ('POW-SAB-43500','POWERMAN','SABER'),
            ('222233-lrtrto','LightRayTech','Retro'),
            ('200002-lrtrto','LightRayTech','Full-Auto');


INSERT INTO Vehicule (immatriculation, marque, modele)
    VALUES  ('657KAN','Honda','Civic'),
            ('5WI89N','Honda','Cicic'),
            ('607G1N','Nissan','Cube'),
            ('YY7KAN','Ferrari','348');

-- chemin fichiers devrait concat le nom du fichier, 
-- nom fichier 'AAA000-00' devvrait être produit à l'aide d'une séquence
INSERT INTO Inspection (date_debut, date_fin, chemin_fichier_donnees, nom_fichier_donnees)
    VALUES  ('2022-10-2 11:40:00','2022-10-2 16:26:00','C:\FichierSecret\Inspections\PZW_POP123-66.xdat', 'PZW_POP123-66.xdat'),
    ('2022-10-16 10:31:00','2022-10-16 15:20:00','C:\FichierSecret\Inspections\PZW_POP123-87.xdat', 'PZW_POP123-87.xdat'),
    ('2022-11-1 9:20:00','2022-11-1 13:59:00','C:\FichierSecret\Inspections\PZW_POP123-88.xdat', 'PZW_POP123-88.xdat'),
    ('2022-11-4 10:20:00','2022-11-4 11:16:00','C:\FichierSecret\Inspections\PZW_POP123-89.xdat', 'PZW_POP123-89.xdat'),
    ('2023-01-7 10:47:00','2023-01-7 19:34:00','C:\FichierSecret\Inspections\PZW_POP123-90.xdat', 'PZW_POP123-90.xdat'),
    ('2023-01-19 11:40:00','2023-01-19 16:26:00','C:\FichierSecret\Inspections\PZW_POP123-91.xdat', 'PZW_POP123-91.xdat'),
    ('2023-02-23 12:20:00','2023-02-23 18:13:00','C:\FichierSecret\Inspections\PZW_POP123-92.xdat', 'PZW_POP123-92.xdat'),
    ('2023-04-14 03:00:00','2023-04-14 17:19:00','C:\FichierSecret\Inspections\PZW_POP123-93.xdat', 'PZW_POP123-93.xdat'),
	('2023-02-12 09:00:00','2023-02-12 17:19:00','C:\FichierSecret\Inspections\PZW_POP123-94.xdat', 'PZW_POP123-94.xdat');
	

INSERT INTO Inspection_laser(inspection_id, employe_id, profileur_laser_id)
    VALUES  (1,(SELECT id FROM employe WHERE nom = 'Banane'), 'POW-PEW-13212'),
            (2,(SELECT id FROM employe WHERE nom = 'Banane'), 'POW-PEW-13212'),
            (3,(SELECT id FROM employe WHERE nom = 'Banane'), 'POW-PEW-13212'),
            (4,(SELECT id FROM employe WHERE nom = 'Banane'), 'POW-SAB-43500'),
            (5,(SELECT id FROM employe WHERE nom = 'Banane'), 'POW-SAB-43500'),
            (6,(SELECT id FROM employe WHERE nom = 'Banane'), '200002-lrtrto'),
            (7,4, '200002-lrtrto'),
            (8,4, '200002-lrtrto'),
			(9,2,'POW-PEW-13212');
	



--probleme serial et id
INSERT INTO Inspection_vehicule (inspection_id, vehicule_id, employe_id, kilometrage_debut, kilometrage_fin)
    VALUES  (1,'657KAN',1,34560,35070),
            (2,'657KAN',1,35900,36700),
            (3,'5WI89N',1,37100,37900),
            (4,'607G1N',2,38500,39202),
            (5,'657KAN',2,40001, 40999),
            (6,'YY7KAN',1,1600,1800),
            (7,'YY7KAN',1,1850,2500),
            (8,'YY7KAN',2,2550, 2900),
            (9,'607G1N',3,2940, 3500);

INSERT INTO liste_inspection_troncon(inspection_id, troncon_id, voie)
    VALUES  (1,1,2),(1,2,2),(1,3,2),
            (2,2,2),(2,3,2),
            (3,2,2),(3,1,2),
            (4,3,2),(4,2,2),
            (5,2,2),(5,1,2),
            (6,3,2),
            (7,2,2),
            (8,3,2);


    





