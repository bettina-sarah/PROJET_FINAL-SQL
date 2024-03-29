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
    ('2023-04-14 03:00:00','2023-04-14 17:19:00','C:\FichierSecret\Inspections\PZW_POP123-93.xdat', 'PZW_POP123-93.xdat');

INSERT INTO Inspection_laser(inspection_id, employe_id, profileur_laser_id)
    VALUES  (1,(SELECT id FROM employe WHERE nom = 'Banane'), 'POW-PEW-13212'),
            (2,(SELECT id FROM employe WHERE nom = 'Banane'), 'POW-PEW-13212'),
            (3,(SELECT id FROM employe WHERE nom = 'Banane'), 'POW-PEW-13212'),
            (4,(SELECT id FROM employe WHERE nom = 'Banane'), 'POW-SAB-43500'),
            (5,(SELECT id FROM employe WHERE nom = 'Banane'), 'POW-SAB-43500'),
            (6,(SELECT id FROM employe WHERE nom = 'Banane'), '200002-lrtrto'),
            (7,4, '200002-lrtrto'),
            (8,4, '200002-lrtrto');



--probleme serial et id
INSERT INTO Inspection_vehicule (inspection_id, vehicule_id, employe_id, kilometrage_debut, kilometrage_fin)
    VALUES  (1,'657KAN',1,34560,35070),
            (2,'657KAN',1,35900,36700),
            (3,'5WI89N',1,37100,37900),
            (4,'607G1N',2,38500,39202),
            (5,'657KAN',2,40001, 40999),
            (6,'YY7KAN',1,1600,1800),
            (7,'YY7KAN',1,1850,2500),
            (8,'YY7KAN',2,2550, 2900);

INSERT INTO liste_inspection_troncon(inspection_id, troncon_id, voie)
    VALUES  (1,2,1),(1,3,2),(1,2,2),
            (2,2,2),(2,3,2),
            (3,2,2),(3,1,2),
            (4,3,2),(4,2,2),
            (5,2,2),(5,1,2),
            (6,3,2),
            (7,2,2),
            (8,3,2);


CREATE OR REPLACE PROCEDURE nouvelle_inspection(
	nom_conducteur VARCHAR(32),
	nom_op_laser VARCHAR(32),
	num_serie_laser CHAR(16),
	immatriculation CHAR(16),
	date_d DATE,
	date_f DATE,
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
    VALUES (date_d, date_f, chemin_fichier, nom_fichieR);

	SELECT id FROM inspection ORDER BY id DESC LIMIT 1 INTO id_insp;
	
	-- Nouvelle inspection vehicule
	INSERT INTO Inspection_vehicule (inspection_id, vehicule_id, employe_id, kilometrage_debut, kilometrage_fin)
	VALUES(id_insp, immatriculation, id_conduc, km_d, km_f);

	-- Nouvelle inspection laser
	INSERT INTO Inspection_laser(inspection_id, employe_id, profileur_laser_id)
    VALUES (id_insp, id_op_las, num_serie_laser);
END;
$$;



    