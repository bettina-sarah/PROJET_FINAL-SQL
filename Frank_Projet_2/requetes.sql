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
lit.inspection_id AS Inspection,
lit.troncon_id AS Troncon,
lit.voie AS Voie,
tr.longueur AS Longueur,
SUM(tr.longueur*lit.voie) AS Total
	FROM liste_inspection_troncon AS "lit"
	INNER JOIN troncon AS "tr" 
		ON tr.id = lit.troncon_id
				GROUP BY  lit.troncon_id, lit.voie, tr.longueur, lit.inspection_id
				ORDER BY lit.inspection_id;
				
SELECT Inspection, SUM(Total)|| ' Km' AS "Distance totale de l''inspection"  FROM vue_longueur_inspection_par_troncon
WHERE inspection = 1
GROUP BY Inspection;

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
-- $/km
SELECT 
Inspection, 
SUM(Total) AS distance,
SUM(Total*1.55) AS cout_D
FROM vue_longueur_inspection_par_troncon
GROUP BY Inspection;
-- temps/inspection
SELECT 
id AS Inspection,
SUM(date_fin- date_debut) AS temps
FROM Inspection
GROUP BY id
ORDER BY id
-- inner join avec la vue à bettina

-- =======================================================



-- =======================================================
-- Requête #7
-- Objectif : 
-- Évaluation : ...
-- Réalisé par : Francois Bouchard
-- ...
-- =======================================================

-- =======================================================