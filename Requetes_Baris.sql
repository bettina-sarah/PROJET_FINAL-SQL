-- =======================================================
-- Requête #7
-- Objectif :
-- Cette requête a pour objectif d'afficher des informations sur les inspections de tronçons routiers, 
-- en utilisant une vue qui a déjà été créée (vue_longueur_inspection_par_troncon).Cette requête donne des détails sur les inspections de tronçons routiers,
--  avec le nom de la rue, la date de début de l'inspection et le nom du conducteur du véhicule associé à chaque inspection.
-- Évaluation : 
-- La requête été difficile à realisé parce que je n'ai pas l'habitude avec une utilisation d'une vue et des jointures qui sont des conceptes assez récent pour moi,
-- mais au final ma requête a fonctionnée et m'a donné le résultat attendu.
-- Réalisé par : 
-- Baris Cocelli
-- =======================================================
-- La requête : 

SELECT 
    vlit.inspection_id AS inspection_id,
    vlit.troncon_id AS troncon_id,
    tr.nom_rue AS nom_rue,
    ins.date_debut AS date_debut_inspection,
    emp_vehicule.nom AS nom_conducteur
FROM 
    vue_longueur_inspection_par_troncon AS vlit
INNER JOIN Troncon AS tr ON vlit.troncon_id = tr.id
INNER JOIN Inspection AS ins ON vlit.inspection_id = ins.id
INNER JOIN Inspection_vehicule AS ins_vehicule ON ins.id = ins_vehicule.inspection_id
INNER JOIN Employe AS emp_vehicule ON ins_vehicule.employe_id = emp_vehicule.id;

-- ======================================================= 





-- =======================================================
-- Requête #7
-- Objectif :
-- Cette requête a pour objectif de récupérer des informations sur les inspections des tronçon , en affichant le nom de l'employé responsable de l'inspection,
-- le département auquel cet employé appartient, la marque du véhicule, ainsi que la date de début de l'inspection.
-- Évaluation : 
-- La requête été difficile à realisé parce que faire des requêtes corrélées sa peut rapidement devenir melangeant et si on ne fais pas attention on peut se perdre dans notre chemins
-- mais au final ma requête a fonctionnée et m'a donné le résultat attendu.
-- Réalisé par : 
-- Baris Cocelli
-- =======================================================
-- La requête : 

SELECT 
    emp.nom AS nom_employe,
    dep.departement_nom AS nom_departement,
    veh.marque AS marque_vehicule,
    ins.date_debut AS date_debut_inspection
FROM 
    Inspection AS ins
INNER JOIN Inspection_vehicule AS ins_vehicule ON ins.id = ins_vehicule.inspection_id
INNER JOIN Employe AS emp ON ins_vehicule.employe_id = emp.id
INNER JOIN Vehicule AS veh ON ins_vehicule.vehicule_id = veh.immatriculation
INNER JOIN Departement AS dep ON emp.departement = dep.departement_nom
WHERE 
    ins.date_debut = (
        SELECT 
            MAX(date_debut) 
        FROM 
            Inspection AS ins_inner 
        WHERE 
            ins_inner.id = ins.id
    );

-- ======================================================= 





-- =======================================================
-- Requête #7
-- Objectif :
-- Cette requête vise à récupérer des informations sur les inspections, en affichant la date de début et de fin de chaque inspection,
-- ainsi que les noms des employés responsables de l'inspection laser et du conducteur du véhicule.
-- Évaluation : 
-- Cette requête était assez simple puisque j'avais moins de contraintes à respecté.
-- Réalisé par : 
-- Baris Cocelli
-- =======================================================
-- La requête : 

SELECT 
    ins.date_debut AS date_debut_inspection,
    ins.date_fin AS date_fin_inspection,
    emp_laser.nom AS nom_employe_laser,
    emp_vehicule.nom AS nom_conducteur
FROM 
    Inspection AS ins
INNER JOIN Inspection_vehicule AS ins_vehicule ON ins.id = ins_vehicule.inspection_id
INNER JOIN Inspection_laser AS ins_laser ON ins.id = ins_laser.inspection_id
INNER JOIN Employe AS emp_vehicule ON ins_vehicule.employe_id = emp_vehicule.id
INNER JOIN Employe AS emp_laser ON ins_laser.employe_id = emp_laser.id;


-- ======================================================= 

