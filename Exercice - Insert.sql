USE papyrus; 
/*     IL FAUT RAJOUTER LE BON CHEMIN POUR LA TABLE VENTE    */
DELETE FROM produit; 

INSERT INTO produit(CODART, LIBART, STKALE, STKPHY, QTEANN, UNIMES) VALUE 
("I100", "Papier 1 ex continu", 100, 557, 3500, "B1000"),
("I105", "Papier 2 ex continu", 75, 5, 2300, "B1000"),
("I108", "Papier 3 ex continu", 200, 557, 3500, "B500"),
("I110", "Papier 4 ex continu", 10, 12, 63, "B400"),
("P220", "Pré imprimé commande", 500, 2500, 24500, "B500"),
("P230", "Pré imprimé facture", 500, 250, 12500, "B500"),
("P240", "Pré imprimé bulletin paie", 500, 3000, 6250, "B500"),
("P250", "Pré imprimé bon livraison", 500, 2500, 24500, "B500"),
("P270", "Pré imprimé bon fabrication", 500, 2500, 24500, "B500"),
("R080", "Ruban Epson 850", 10, 2, 120, "unité"),
("R132", "Ruban imp 1200 lignes", 25, 200, 182, "unité"),
("B002", "Bande manétiques 6250", 20, 12, 410, "unité"),
("B001", "Bande manétiques 1200", 20, 12, 410, "unité"),
("D035", "CD R slim 80 mm", 40, 42, 150, "B010"),
("D050", "CD R-W 80 mm", 50, 4, 0, "B010");


DELETE FROM fournis; 

INSERT INTO fournis(NUMFOU, NOMFOU, RUEFOU, POSFOU, VILFOU, CONFOU, SATISF) VALUE 
(00120, "GROBRIGAN", "20 rue du papier", "92200", "Papercity", "Georges", 08),
(00540, "ECLIPSE", "53 rue Laisse Flotter les rubans", "78250", "Bugbug-Ville", "Nestor", 07),
(08700, "MEDICIS", "120 rue des Plantes", "75014", "Paris", "Lison", 0),
(09120, "DISCOBOL", "11 rue des Sports", "85100", "La Roche sur Yon", "Hercule", 08),
(09150, "DEPANPAP", "26 avenue des Locomotives", "59987", "Corocountry", "Pollux", 05),
(09180, "HURRYTAPE", "68 boulevard des Octets", "04044", "Dumpville", "Track", 0);

DELETE FROM entcom; 


INSERT INTO entcom(NUMCOM, OBSCOM, DATCOM, NUMFOU) VALUE 
(70010, "", '2007-02-10 12:58:47', 00120),
(70011, "Commande Urgente", '2007-03-01 13:10:40', 00540),
(70020, "", '2007-04-25 10:45:11', 09180),
(70025, "Commande Urgente", '2007-04-30 21:00:01', 09150),
(70210, "Commande Condencée", '2007-05-05 08:24:50', 00120),
(70300, "", '2007-06-06 09:53:47', 09120),
(70250, "Commande Condencée", '2007-10-02 16:06:20', 08700),
(70620, "", '2007-10-02 12:00:15', 00540),
(70625, "", '2007-10-17:14:41', 00120),
(70629, "", '2007-10-12 19:31:19', 09180);

DELETE FROM ligcom; 

INSERT INTO ligcom(NUMLIG, QTECDE, PRIUNI, QTELIV, DERLIV, NUMCOM, CODART) VALUE 
(01, 3000, 470.00, 3000, '2007-03-15', 70010, "I100"),
(02, 2000, 485.00, 2000, '2007-07-05', 70010, "I105"),
(03, 1000, 680.00, 1000, '2007-08-20', 70010, "I108"),
(04, 200, 40.00, 250, '2007-02-20', 70010, "D035"),
(05, 6000, 3500.00, 6000, '2007-03-31', 70010, "P220"),
(06, 6000, 2000.00, 2000, '2007-03-31', 70010, "P240"),
(01, 1000, 600.00, 1000, '2007-05-16', 70011, "I105"),
(01, 200, 140.00, 0, '2007-12-31', 70020, "B001"),
(02, 200, 140.00, 0, '2007-12-31', 70020, "B002"),
(01, 1000, 590.00, 1000, '2007-05-15', 70025, "I100"),
(02, 500, 590.00, 500, '2007-05-15', 70025, "I105"),
(01, 1000, 470.00, 1000, '2007-07-15', 70210, "I100"),
(02, 10000, 3500.00, 10000, '2007-08-31', 70210, "P220"),
(01, 50, 790.00, 50, '2007-10-31', 70300, "I110"),
(01, 15000, 4900.00, 12000, '2007-12-15', 70250, "P230"),
(02, 10000, 3350.00, 10000, '2007-11-10', 70250, "P220"),
(01, 200, 600.00, 200, '2007-11-01', 70620, "I105"),
(01, 1000, 470.00, 1000, '2007-10-15', 70625, "I100"),
(02, 10000, 3500.00, 10000, '2007-10-31', 70625, "P220"),
(01, 200, 140.00, 0, '2007-12-31', 70629, "B001"),
(02, 200, 140.00, 0, '2007-12-31', 70629, "B002");

DELETE FROM vente; 

LOAD DATA LOCAL INFILE 'vente.csv'
INTO TABLE vente
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(NUMFOU,CODART,DELLIV,QTE1,PRIX1,QTE2,PRIX2,QTE3,PRIX3);