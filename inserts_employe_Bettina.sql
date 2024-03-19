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




