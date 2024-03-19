-- ************ INSERT BETTINA: poste, departement, employe

-- *** POSTE:

INSERT INTO poste (poste_nom)
	VALUES 	('professionnel'),
	 		('technicien'),
			('ingénieur'),
			('scientifique'),
			('manutentionnaire'),
			('soutient');

-- *** DEPARTEMENT:

INSERT INTO departement (departement_nom)
	VALUES	('administration'),
			('ventes et représentation'),
			('achats'),
			('mécanique'),
			('électrique'),
			('informatique'),
			('recherche');

-- *** EMPLOYE:

INSERT INTO employe (nom, prenom, genre, nas, date_embauche, salaire_horaire, poste, departement) --salaire: defaut
	VALUES 	('Banane', 'Jean', 'h', 123456789, '2018-05-20', 'professionnel', 'achats'),
	VALUES 	('Couronne', 'Veruce', 'x', 666666666, '2020-03-01', 250.00, 'scientifique', 'recherche'),
	VALUES 	('Lebel', 'Veronique', 'f', 888444222, '2022-04-02', 100.50, 'ingénieur', 'mécanique'),
			('LeGrand', 'Chad', 'h', 111222333, CURRENT_DATE, 15.00, 'soutient', 'ventes et représentation');


INSERT INTO employe (nom, prenom, genre, nas, date_embauche, poste, departement) --salaire: defaut
	VALUES 	('Banane', 'Jean', 'h', 123456789, '2018-05-20', 'professionnel', 'achats'),
			('Jesus', 'Marie', 'f', 555999777, '2018-12-24', 'manutentionnaire', 'administration');









