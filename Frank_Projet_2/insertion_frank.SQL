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
INSERT INTO Inspection (date_debut, date_fin, chemin_fichier_donnees, nom_fichier_donnees)l
    VALUES  ('2022-10-2 11:40:00','2022-10-2 16:26:00','C:\FichierSecret\Inspections\PZW_POP123-66.xdat', 'PZW_POP123-66.xdat'),
    ('2022-10-16 10:31:00','2022-10-16 15:20:00','C:\FichierSecret\Inspections\PZW_POP123-87.xdat', 'PZW_POP123-87.xdat'),
    ('2022-11-1 9:20:00','2022-11-1 13:59:00','C:\FichierSecret\Inspections\PZW_POP123-88.xdat', 'PZW_POP123-88.xdat'),
    ('2022-11-4 10:20:00','2022-11-4 11:16:00','C:\FichierSecret\Inspections\PZW_POP123-89.xdat', 'PZW_POP123-89.xdat'),
    ('2023-01-7 10:47:00','2023-01-7 19:34:00','C:\FichierSecret\Inspections\PZW_POP123-90.xdat', 'PZW_POP123-90.xdat'),
    ('2023-01-19 11:40:00','2023-01-19 16:26:00','C:\FichierSecret\Inspections\PZW_POP123-91.xdat', 'PZW_POP123-91.xdat'),
    ('2023-02-23 12:20:00','2023-02-23 18:13:00','C:\FichierSecret\Inspections\PZW_POP123-92.xdat', 'PZW_POP123-92.xdat'),
    ('2023-04-14 03:00:00','2023-04-2 17:19:00','C:\FichierSecret\Inspections\PZW_POP123-93.xdat', 'PZW_POP123-93.xdat');

INSERT INTO Inspection_laser(employe_id, profileur_laser_id)
    VALUES  ((SELECT id FROM employe WHERE nom = 'Banane'), 'POW-PEW-13212'),
            ((SELECT id FROM employe WHERE nom = 'Banane'), 'POW-PEW-13212'),
            ((SELECT id FROM employe WHERE nom = 'Banane'), 'POW-PEW-13212'),
            ((SELECT id FROM employe WHERE nom = 'Banane'), 'POW-SAB-43500'),
            ((SELECT id FROM employe WHERE nom = 'Banane'), 'POW-SAB-43500'),
            ((SELECT id FROM employe WHERE nom = 'Banane'), '200002-lrtrto');

INSERT INTO liste_inspection_laser (inspection_id, inpsection_laser_id)
    VALUES  ((SELECT id FROM Inspection WHERE nom_fichier_donnees = 'PZW_POP123-66.xdat'), (SELECT id FROM Inspection_laser WHERE profileur_laser_id = '200002-lrtrto')),
            ((SELECT id FROM Inspection WHERE nom_fichier_donnees = 'PZW_POP123-87.xdat'), 2),
            ((SELECT id FROM Inspection WHERE nom_fichier_donnees = 'PZW_POP123-88.xdat'), 3),
            (4, 3),
            (5, 3),
            (6, 4),
            (7, 4),
            (8, 5),

-- probleme serial et id
INSERT INTO Inspection_vehicule (vehicule_id, employe_id, kilometrage_debut, kilometrage_fin)
    VALUES  ('657KAN',1,34560,35070),
            ('657KAN',1,35900,36700),
            ('5WI89N',1,37100,37900),
            ('607G1N',2,38500,39202),
            ('657KAN',2,40001, 40999), ('657KAN',2,39300, 39700), ('657KAN',2,39730, 40012),
            ('YY7KAN',1,1600,1800),
            ('YY7KAN',1,1850,2500),
            ('YY7KAN',2,2550, 2900);

-- probleme serial et id
INSERT INTO liste_inspection_info_vehicule(inspection_id, inspection_vehicule_id)
    VALUES (1,61),(2,62),(3,63),(4,64),(5,65),(5,66),(5,67),(6,68),(7,69),(8,70);

    