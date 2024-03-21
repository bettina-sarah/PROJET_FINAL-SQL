-- 
-- =======================================================
-- Requête #5
-- Objectif : Pour une inspection donnée, combien de kilomètres ont été parcourus.
-- Évaluation : ...
-- Réalisé par : Francois Bouchard
-- ...
-- =======================================================
SELECT inspection_id AS "Inspection", SUM(kilometrage_fin - kilometrage_debut) AS "Total KM"
FROM Inspection_vehicule
WHERE inspection_id = 1
GROUP BY inspection_id

SELECT 
lit.troncon_id AS "Troncon",
lit.voie AS "Voie",
tr.longueur AS "Longueur"
	FROM liste_inspection_troncon AS "lit"
	INNER JOIN troncon AS "tr" 
		ON tr.id = lit.troncon_id
			WHERE inspection_id = 1

SELECT 
lit.troncon_id AS "Troncon",
lit.voie AS "Voie",
tr.longueur AS "Longueur",
SUM(tr.longueur*lit.voie) AS "Total"
	FROM liste_inspection_troncon AS "lit"
	INNER JOIN troncon AS "tr" 
		ON tr.id = lit.troncon_id
			WHERE inspection_id = 1
				GROUP BY lit.troncon_id, lit.voie, tr.longueur

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

-- =======================================================



-- =======================================================
-- Requête #7
-- Objectif : 
-- Évaluation : ...
-- Réalisé par : Francois Bouchard
-- ...
-- =======================================================

-- =======================================================