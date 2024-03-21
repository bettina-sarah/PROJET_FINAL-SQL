
-- =======================================================
-- Requête 1
-- Objectif : Donner la liste des employés : nom, prénom, poste, nom du département, ancienneté (en année),
-- leur salaire annuel (considérant qu’ils travaillent 35 heures par semaine et 52 semaines par année)
-- et leur salaire annuel augmenté de 15%

-- Évaluation : Fonctionnelle

-- Réalisé par : Emeric 
-- =======================================================
SELECT ROUND((EXTRACT(DAY FROM NOW() - date_embauche))/365.0 , 2) as anciennete
FROM Employe;

SELECT 
	nom,
	prenom,
	poste,
	departement,
	ROUND((EXTRACT(DAY FROM NOW() - date_embauche))/365.0 , 2) as anciennete,
	35 * 52 * salaire_horaire as salaire_annuel,
	ROUND(35 * 52 * salaire_horaire * 1.15 , 2) as salaire_annuel_bonnifie
	FROM Employe
ORDER BY anciennete DESC;
-- =======================================================



-- =======================================================
-- Requête 4
-- Objectif : Pour chaque profileur laser, donner le nombre d’heures totales utilisées pour des inspections.
-- Évaluation : Fonctionnelle
-- Réalisé par : Emeric
-- =======================================================
SELECT 
    inspection_laser.profileur_laser_id,
    SUM(Inspection.date_fin - Inspection.date_debut) AS total_time
FROM
    inspection_laser
JOIN
    Inspection ON inspection_laser.inspection_id = Inspection.id
GROUP BY
    inspection_laser.profileur_laser_id;
-- =======================================================

-- =======================================================
-- Requête 7
-- Objectif : 
-- Évaluation : 
-- Réalisé par : Emeric
-- =======================================================
SELECT
	liste_reseau_troncon_intersection.reseau_id,
	liste_reseau_troncon_intersection.troncon_id,
	Troncon.nom_rue,
	liste_inspection_troncon.Inspection_id,
	Inspection.id
FROM
	liste_reseau_troncon_intersection
JOIN
	Troncon ON liste_reseau_troncon_intersection.troncon_id = Troncon.id
JOIN
	liste_inspection_troncon ON Troncon.id = liste_inspection_troncon.troncon_id
JOIN
	Inspection ON liste_inspection_troncon.troncon_id = Inspection.id
-- =======================================================


-- 7. Chaque étudiant doit réaliser 1 requête pertinente de son cru. La requête doit utiliser au
-- minimum 4 tables. De plus, dans l’équipe, une requête doit utiliser une vue, une autre doit faire
-- une requête corrélée. Le pointage associé à chacune de ces requêtes est autant basé sur la
-- pertinence que la qualité de la réalisation technique.