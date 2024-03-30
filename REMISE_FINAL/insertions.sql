
DROP VIEW IF EXISTS vue_longueur_inspection_par_troncon CASCADE;
DROP VIEW IF EXISTS vue_inspection_vehicule_laser_employe CASCADE;
DROP VIEW IF EXISTS vue_inspection_stats CASCADE;


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

--------- ******************* BETTINA: Création TRIGGERS & FONCTIONS pour les inserts employé

--Fonction pour le trigger du poste:
CREATE OR REPLACE FUNCTION fonction_poste() RETURNS TRIGGER
LANGUAGE PLPGSQL AS $$
BEGIN
IF NEW.poste NOT IN (SELECT poste_nom FROM poste) THEN
        RAISE EXCEPTION 'Poste n"existe pas';
    END IF;
    RETURN NEW;
END;
$$;

-- TRIGGER pour AVANT l'insertion du poste dans employe
CREATE OR REPLACE TRIGGER trigger_poste
	BEFORE INSERT
	ON employe
	FOR EACH ROW
	EXECUTE FUNCTION fonction_poste();
	

--Fonction pour le trigger du departement:
CREATE OR REPLACE FUNCTION fonction_departement() RETURNS TRIGGER
LANGUAGE PLPGSQL AS $$
BEGIN
IF NEW.departement NOT IN (SELECT departement_nom FROM departement) THEN
        RAISE EXCEPTION 'Departement n"existe pas!';
    END IF;
    RETURN NEW;
END;
$$;

-- TRIGGER pour AVANT l'insertion du departement dans employe
CREATE OR REPLACE TRIGGER trigger_departement
	BEFORE INSERT
	ON employe
	FOR EACH ROW
	EXECUTE FUNCTION fonction_departement();



-- ************************trigger FRANK pour création insert_liste_troncon_inspection

	CREATE OR REPLACE FUNCTION ajouter_liste_troncon_inspection()
		RETURNS TRIGGER
	LANGUAGE PLPGSQL AS $$
	BEGIN
    -- force le nombre de voie inspecter à être le nombre de voie du troncon
		SELECT nb_voies FROM troncon WHERE troncon.id = New.troncon_id INTO New.voie;
		RETURN NEW;
	END;
$$;

CREATE OR REPLACE TRIGGER ajouter_liste_troncon_inspection_trig
	BEFORE INSERT ON liste_inspection_troncon
	FOR EACH ROW
	EXECUTE PROCEDURE ajouter_liste_troncon_inspection();


-- ********************************** Procedure FRANK
-- Fonction pour ajouter des inspection !!!! les troncons d'une inspection ne sont INSERT par cette procédure !!!
CREATE OR REPLACE PROCEDURE nouvelle_inspection(
	nom_conducteur VARCHAR(32),
	nom_op_laser VARCHAR(32),
	num_serie_laser CHAR(16),
	immatriculation CHAR(16),
	date_d TIMESTAMP,
	date_f TIMESTAMP,
	km_d DECIMAL(8,2),
	km_f DECIMAL(8,2),
	chemin_fichier VARCHAR(512),
	nom_fichier CHAR(18)
	)
LANGUAGE PLPGSQL
AS $$
    DECLARE
        id_conduc INTEGER;
        id_op_las INTEGER;
        id_insp INTEGER;
    BEGIN
        SELECT id from employe WHERE nom = nom_conducteur INTO id_conduc;
        SELECT id from employe WHERE nom = nom_op_laser INTO id_op_las;
        
        -- Nouvelle inspection
        INSERT INTO Inspection (date_debut, date_fin, chemin_fichier_donnees, nom_fichier_donnees)
        VALUES (date_d, date_f, chemin_fichier, nom_fichier);

        SELECT id FROM inspection ORDER BY id DESC LIMIT 1 INTO id_insp;
        
        -- Nouvelle inspection vehicule
        INSERT INTO Inspection_vehicule (inspection_id, vehicule_id, employe_id, kilometrage_debut, kilometrage_fin)
        VALUES(id_insp, immatriculation, id_conduc, km_d, km_f);

        -- Nouvelle inspection laser
        INSERT INTO Inspection_laser(inspection_id, employe_id, profileur_laser_id)
        VALUES (id_insp, id_op_las, num_serie_laser);
    END;
$$;  

-- ************************************************************************************************************

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

-- ***************************************************** INSERT FRANK

INSERT INTO Profileur_laser (num_serie, marque, modele)
    VALUES  ('POW-PEW-13212','POWERMAN','FULLPEW'),
            ('POW-PEW-44312','POWERMAN','FULLPEW'),
            ('POW-SAB-43500','POWERMAN','SABER'),
            ('222233-lrtrto','LightRayTech','Retro'),
            ('200002-lrtrto','LightRayTech','Full-Auto');


INSERT INTO Vehicule (immatriculation, marque, modele)
    VALUES  ('657KAN','Honda','Civic'),
            ('5WI89N','Honda','Civic'),
            ('607G1N','Nissan','Cube'),
            ('YY7KAN','Ferrari','348');


--conducteur, laser_guy, num_laser, immatriculation_vehicule, date_d, date_f, km_d, km_f, chemin_fichier, nom_fichier
CALL nouvelle_inspection('Jesus', 'LeGrand', 'POW-PEW-44312', 'YY7KAN', '2023-04-15 09:00:00', '2023-04-15 17:00:00', 1600,1800,
	'C:\FichierSecret\Inspections\PZW_POP123-01.xdat','PZW_POP123-01.xdat');

CALL nouvelle_inspection('Jesus', 'LeGrand', 'POW-PEW-44312', 'YY7KAN', '2023-04-16 09:00:00', '2023-04-16 17:00:00', 1850,2500,
	'C:\FichierSecret\Inspections\PZW_POP123-02.xdat','PZW_POP123-02.xdat');

CALL nouvelle_inspection('Jesus', 'LeGrand', 'POW-PEW-44312', 'YY7KAN', '2023-04-17 09:00:00', '2023-04-17 17:00:00', 2550, 2900,
	'C:\FichierSecret\Inspections\PZW_POP123-03.xdat','PZW_POP123-03.xdat');

CALL nouvelle_inspection('Banane', 'Jesus', 'POW-PEW-13212', 'YY7KAN', '2023-04-18 09:00:00', '2023-04-18 17:00:00', 2900, 6000,
	'C:\FichierSecret\Inspections\PZW_POP123-04.xdat','PZW_POP123-04.xdat');

CALL nouvelle_inspection('Lebel', 'Banane', 'POW-PEW-13212', '657KAN', '2023-04-19 06:00:00', '2023-04-19 12:00:00', 34560,35070,
	'C:\FichierSecret\Inspections\PZW_POP123-05.xdat','PZW_POP123-05.xdat');

CALL nouvelle_inspection('Banane', 'LeGrand', 'POW-PEW-13212', '657KAN', '2023-04-20 06:00:00', '2023-04-20 12:00:00', 35900,36700,
	'C:\FichierSecret\Inspections\PZW_POP123-06.xdat','PZW_POP123-06.xdat');

CALL nouvelle_inspection('Lebel', 'Jesus', '200002-lrtrto', '657KAN', '2023-04-21 06:00:00', '2023-04-21 12:00:00', 40001, 40999,
	'C:\FichierSecret\Inspections\PZW_POP123-07.xdat','PZW_POP123-07.xdat');

CALL nouvelle_inspection('Banane', 'Couronne', '200002-lrtrto', '5WI89N', '2023-04-22 09:00:00', '2023-04-22 17:00:00', 2900, 4000,
	'C:\FichierSecret\Inspections\PZW_POP123-08.xdat','PZW_POP123-08.xdat');

CALL nouvelle_inspection('Lebel', 'Couronne', '200002-lrtrto', '5WI89N', '2023-04-23 09:00:00', '2023-04-23 20:00:00', 4100, 5000,
	'C:\FichierSecret\Inspections\PZW_POP123-09.xdat','PZW_POP123-09.xdat');

CALL nouvelle_inspection('Banane', 'Couronne', '200002-lrtrto', '5WI89N', '2023-04-24 06:00:00', '2023-04-24 17:00:00', 5100, 6020,
	'C:\FichierSecret\Inspections\PZW_POP123-10.xdat','PZW_POP123-10.xdat');

CALL nouvelle_inspection('Couronne', 'LeGrand', '222233-lrtrto', '607G1N', '2023-04-25 09:00:00', '2023-04-25 17:00:00', 37100,37900,
	'C:\FichierSecret\Inspections\PZW_POP123-11.xdat','PZW_POP123-11.xdat');
	
CALL nouvelle_inspection('Couronne', 'Lebel', 'POW-PEW-13212', '5WI89N', '2023-05-23 09:00:00', '2023-05-23 13:00:00', 5000,5200,
	'C:\FichierSecret\Inspections\PZW_POP123-12.xdat','PZW_POP123-12.xdat');


INSERT INTO liste_inspection_troncon(inspection_id, troncon_id)
    VALUES  (1,1),(1,2),(1,3),
            (2,2),(2,3),
            (3,2),(3,1),
            (4,3),(4,2),
            (5,2),(5,1),
            (6,3),
            (7,2),
            (8,3),
            (9,1),(9,2),(9,3),
            (10,1),(10,3),
            (11,1),(11,2),
	    (12,1),(12,2);


-- **************************** VUE Frank****************************


CREATE VIEW vue_longueur_inspection_par_troncon AS
SELECT 
lit.inspection_id AS Inspection_id,
lit.troncon_id AS Troncon_id,
lit.voie AS Voie,
tr.longueur AS Longueur,
SUM(tr.longueur*lit.voie) AS Total
	FROM liste_inspection_troncon AS "lit"
	INNER JOIN troncon AS "tr" 
		ON tr.id = lit.troncon_id
				GROUP BY  lit.troncon_id, lit.voie, tr.longueur, lit.inspection_id
				ORDER BY lit.inspection_id;


CREATE VIEW vue_inspection_stats AS
SELECT 
vlit.inspection_id AS inspection_id, 
ROUND(SUM(vlit.Total/1000),2) AS Distance_totale_KM,
(ins.date_fin - ins.date_debut) AS Duree_totale,
ROUND(SUM(vlit.Total/1000)*1.55,2) AS Cout_total
FROM vue_longueur_inspection_par_troncon AS vlit
INNER JOIN Inspection AS ins
ON ins.id = vlit.inspection_id
GROUP BY inspection_id, ins.date_fin, ins.date_debut
ORDER BY inspection_id;

-- **************************** VUE Bettina ****************************


CREATE VIEW vue_inspection_vehicule_laser_employe AS
	SELECT 
    inspection.id AS inspection_id,
    inspection_vehicule.id AS inspection_vehicule_id,
    inspection_vehicule.employe_id AS employe_id_vehicule,
	emp_vehicule.nom AS Nom_employe_vehicule,
	emp_vehicule.prenom AS Prenom_employe_vehicule,
	inspection_laser.employe_id AS employe_id_laser,
	emp_laser.nom AS Nom_employe_laser,
	emp_laser.prenom AS Prenom_employe_laser
FROM 
    inspection 
JOIN 
    inspection_vehicule ON inspection.id = inspection_vehicule.inspection_id
JOIN
	inspection_laser ON inspection.id = inspection_laser.inspection_id
JOIN
	employe AS emp_vehicule ON inspection_vehicule.employe_id = emp_vehicule.id
JOIN employe AS emp_laser ON inspection_laser.employe_id = emp_laser.id;


  





