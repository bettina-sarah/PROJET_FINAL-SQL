
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
    Inspection_laser.profileur_laser_id,
	Profileur_laser.marque,
	Profileur_laser.modele,
    SUM(Inspection.date_fin - Inspection.date_debut) AS total_time
FROM
    Inspection_laser
JOIN
    Inspection ON inspection_laser.inspection_id = Inspection.id
JOIN
	Profileur_laser ON inspection_laser.profileur_laser_id = Profileur_laser.num_serie
GROUP BY
    Inspection_laser.profileur_laser_id,
	Profileur_laser.marque,
    Profileur_laser.modele
ORDER BY
	total_time DESC;
-- =======================================================

-- =======================================================
-- Requête 7
-- Objectif : Pour chaque Réseau Routier, donner le id la marque ainsi que le modèle de la voiture et du profileur laser le plus utilisé
-- Évaluation : 
-- Réalisé par : Emeric
-- =======================================================
WITH Laser_Usage AS (
    SELECT 
        Reseau_routier.nom AS nom_reseau,
        Profileur_laser.num_serie AS Laser_numero_serie,
        Profileur_laser.marque AS Laser_Marque,
        Profileur_laser.modele AS Laser_Modele,
        Inspection.id AS inspection_id,
        EXTRACT(EPOCH FROM (MAX(Inspection.date_fin) - MIN(Inspection.date_debut))) AS total_usage_time
    FROM
        liste_inspection_troncon
    JOIN
        Troncon ON liste_inspection_troncon.troncon_id = Troncon.id
    JOIN
        liste_reseau_troncon_intersection ON Troncon.id = liste_reseau_troncon_intersection.troncon_id
    JOIN
        Reseau_routier ON liste_reseau_troncon_intersection.reseau_id = Reseau_routier.id
    JOIN 
        Inspection ON liste_inspection_troncon.inspection_id = Inspection.id
    JOIN
        Inspection_laser ON Inspection.id = Inspection_laser.inspection_id
    JOIN
        Profileur_laser ON Inspection_laser.profileur_laser_id = Profileur_laser.num_serie
    GROUP BY
        Reseau_routier.nom,
        Profileur_laser.num_serie,
        Profileur_laser.marque,
        Profileur_laser.modele,
        Inspection.id
)
SELECT
    nom_reseau,
    Laser_numero_serie,
    Laser_Marque,
    Laser_Modele,
    total_usage_time,
    TO_CHAR(INTERVAL '1 second' * total_usage_time, 'HH24:MI:SS') AS total_usage_time_formatted
FROM (
    SELECT
        nom_reseau,
        Laser_numero_serie,
        Laser_Marque,
        Laser_Modele,
        total_usage_time,
        ROW_NUMBER() OVER (PARTITION BY nom_reseau ORDER BY total_usage_time DESC) AS laser_rank
    FROM (
        SELECT
            nom_reseau,
            Laser_numero_serie,
            Laser_Marque,
            Laser_Modele,
            SUM(total_usage_time) AS total_usage_time
        FROM
            Laser_Usage
        GROUP BY
            nom_reseau,
            Laser_numero_serie,
            Laser_Marque,
            Laser_Modele
    ) grouped
) ranked
WHERE
    laser_rank = 1;


-- =======================================================


-- 7. Chaque étudiant doit réaliser 1 requête pertinente de son cru. La requête doit utiliser au
-- minimum 4 tables. De plus, dans l’équipe, une requête doit utiliser une vue, une autre doit faire
-- une requête corrélée. Le pointage associé à chacune de ces requêtes est autant basé sur la
-- pertinence que la qualité de la réalisation technique.



