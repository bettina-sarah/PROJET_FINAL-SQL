-- =======================================================
-- Requête #2
-- Objectif : Donner le nombre d’inspections que chaque employé a fait (qu’il ait participé au inspection par
--la conduite du véhicule ou par l’opération du profilomètre).
-- ...
-- ...
-- Évaluation : fonctionelle
-- ...
-- ...
-- Réalisé par : Bettina
-- ...
-- =======================================================
-- *** créer vue: 

-- DROP VIEW IF EXISTS vue_inspection_vehicule_laser_employe CASCADE;
-- CREATE VIEW vue_inspection_vehicule_laser_employe AS
-- 	SELECT 
--     inspection.id AS inspection_id,
--     inspection_vehicule.id AS inspection_vehicule_id,
--     inspection_vehicule.employe_id AS employe_id_vehicule,
-- 	emp_vehicule.nom AS Nom_employe_vehicule,
-- 	emp_vehicule.prenom AS Prenom_employe_vehicule,
-- 	inspection_laser.employe_id AS employe_id_laser,
-- 	emp_laser.nom AS Nom_employe_laser,
-- 	emp_laser.prenom AS Prenom_employe_laser
-- FROM 
--     inspection 
-- JOIN 
--     inspection_vehicule ON inspection.id = inspection_vehicule.inspection_id
-- JOIN
-- 	inspection_laser ON inspection.id = inspection_laser.inspection_id
-- JOIN
-- 	employe AS emp_vehicule ON inspection_vehicule.employe_id = emp_vehicule.id
-- JOIN employe AS emp_laser ON inspection_laser.employe_id = emp_laser.id;

	
-- requete sur VUE:

SELECT
	nom_employe_laser AS "Nom employe laser",
    prenom_employe_laser AS "Prenom employe laser",
	COUNT(nom_employe_laser) AS "Nombre d''inspections avec le laser par employé",
	nom_employe_vehicule AS "Nom employe vehicule",
    prenom_employe_vehicule AS "Prenom employe vehicule",
	COUNT(nom_employe_vehicule) AS "Nombre d''inspections en vehicule par employé"
FROM
	vue_inspection_vehicule_laser_employe
GROUP BY
	nom_employe_laser, prenom_employe_laser,
	nom_employe_vehicule, prenom_employe_vehicule;
-- ======================================================= 





-- =======================================================
-- Requête #3
-- Objectif : Pour chaque véhicule, combien de kilomètres d’inspection ont été parcourus pour les inspections.
-- ...
-- ...
-- Évaluation : fonctionelle
-- ...
-- ...
-- Réalisé par : Bettina
-- ...
-- =======================================================
--votre requête
-- ======================================================= 