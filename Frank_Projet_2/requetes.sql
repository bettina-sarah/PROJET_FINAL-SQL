-- 
-- =======================================================
-- Requête #5
-- Objectif : Pour une inspection donnée, combien de kilomètres ont été parcourus.
-- Évaluation : ...
-- Réalisé par : Francois Bouchard
-- ...
-- =======================================================
DROP VIEW IF EXISTS vue_longueur_inspection_par_troncon CASCADE;
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
				
SELECT Inspection_id, SUM(Total)|| ' Km' AS "Distance totale de l''inspection"  FROM vue_longueur_inspection_par_troncon
WHERE inspection_id = 1
GROUP BY Inspection_id;

-- =======================================================



-- =======================================================
-- Requête #6
-- Objectif : Pour chacune des inspections, on désire savoir quels ont été les frais associés (vous devez tenir
-- compte du temps passé pour les deux employés lors de l’inspection, des coûts d’exploitation du
-- véhicule à 1.55$ par kilomètre). 
-- Évaluation : ...
-- Réalisé par : Francois Bouchard
-- ...
-- =======================================================

DROP VIEW IF EXISTS vue_inspection_stats CASCADE;
CREATE VIEW vue_inspection_stats AS
	
SELECT 
vlit.inspection_id AS inspection_id, 
SUM(Total) AS Distance_totale,
SUM(date_fin- date_debut) AS Duree_totale,
SUM(Total*1.55) AS cout_total
FROM vue_longueur_inspection_par_troncon AS vlit
INNER JOIN Inspection AS ins
ON ins.id = vlit.inspection_id
GROUP BY inspection_id
ORDER BY inspection_id


SELECT 
vis.inspection_id AS id,
ROUND(vis.cout_total,2) ||'$' AS cout_exploitation,
(empv.salaire_horaire * EXTRACT(HOUR FROM vis.duree_totale))||'$' AS "cout_conducteur",
(empl.salaire_horaire * EXTRACT(HOUR FROM vis.duree_totale))||'$' AS "cout_laser"
FROM vue_inspection_stats AS vis
INNER JOIN vue_inspection_vehicule_laser_employe AS vivle
ON vis.inspection_id = vivle.inspection_id
INNER JOIN employe AS empv
ON empv.id = vivle.employe_id_vehicule
INNER JOIN employe AS empl
ON empl.id = vivle.employe_id_laser;


-- =======================================================



-- =======================================================
-- Requête #7
-- Objectif : 
-- Évaluation : ...
-- Réalisé par : Francois Bouchard
-- ...
-- =======================================================

-- =======================================================