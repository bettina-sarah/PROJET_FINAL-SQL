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
ROUND(SUM(Total/1000),2) AS Distance_totale_KM,
SUM(date_fin - date_debut) AS Duree_totale,
ROUND(SUM(Total/1000)*1.55,2) AS Cout_total
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

SELECT
DISTINCT vehicule_id AS Vech
FROM vehicule AS veh
INNER JOIN inspection_vehicule AS insv
ON veh.immatriculation = insv.vehicule_id
INNER JOIN liste_inspection_troncon AS inst
ON inst.inspection_id = insv.inspection_id
INNER JOIN troncon AS tronc
ON tronc.id = inst.troncon_id
GROUP BY vehicule_id

-- =======================================================


SELECT 
    veh.immatriculation AS Vehicule,
    (
        SELECT lrti.intersection_debut_id
        FROM inspection_vehicule AS insv
        INNER JOIN liste_inspection_troncon AS inst ON inst.inspection_id = insv.inspection_id
        INNER JOIN troncon AS tronc ON tronc.id = inst.troncon_id
        INNER JOIN liste_reseau_troncon_intersection AS lrti ON tronc.id = lrti.troncon_id
        WHERE insv.vehicule_id = veh.immatriculation
        ORDER BY lrti.intersection_debut_id
    ) AS debut_fin
FROM 
    vehicule AS veh
ORDER BY 
    veh.immatriculation;