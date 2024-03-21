INSERT INTO Troncon (nom_rue, longueur, lim_vitesse, nb_voies, type_pavage)
    VALUES  ('Viau',750.0, 40, 2, 'asphalte'),
            ('Viau', 1000.0, 40, 2, 'asphalte'),
            ('Rosemont', 1100.0, 50, 2, 'asphalte');
        


INSERT INTO Intersection (latitude, longitude, type_pavage )
    VALUES (45.562518, -73.546013, 'asphalte'), -- viau/PC
            (45.565307, -73.554358, 'asphalte'), -- viau/sherb
            (45.569234, -73.566277, 'asphalte'), -- viau/rosemont
            (45.560802, -73.573757, 'asphalte'); -- rosemont/pieIX


INSERT INTO Reseau_routier (nom)
    VALUES ('Parc Maisonneuve');

INSERT INTO liste_reseau_troncon_intersection (reseau_id, troncon_id, intersection_debut_id, intersection_fin_id)
    VALUES (1, 1, 10000, 10001 ),
            (1, 1, 10001, 10000),
            (1, 2, 10001, 10002),
            (1, 2, 10002, 10001),
            (1, 3, 10002, 10003),
            (1, 3, 10003, 10002);
