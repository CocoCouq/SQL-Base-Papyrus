DROP DATABASE papyrus;

CREATE DATABASE papyrus;

USE papyrus;

CREATE TABLE `fournis` (
  `numfou` int NOT NULL,
  `nomfou` varchar(25) NOT NULL,
  `ruefou` varchar(50) NOT NULL,
  `posfou` char(5) NOT NULL,
  `vilfou` varchar(30) NOT NULL,
  `confou` varchar(15) NOT NULL,
  `satisf` tinyint(4) DEFAULT NULL, 
  CHECK (`satisf` >=0 AND `satisf` <=10),
  PRIMARY KEY (`numfou`)
);

INSERT INTO `fournis` (`numfou`, `nomfou`, `ruefou`, `posfou`, `vilfou`, `confou`, `satisf`) VALUES
	(120, 'GROBRIGAN', '20 rue du papier', '92200', 'papercity', 'Georges', 8),
	(540, 'ECLIPSE', '53 rue laisse flotter les rubans', '78250', 'Bugbugville', 'Nestor', 7),
	(8700, 'MEDICIS', '120 rue des plantes', '75014', 'Paris', 'Lison', 0),
	(9120, 'DISCOBOL', '11 rue des sports', '85100', 'La Roche sur Yon', 'Hercule', 8),
	(9150, 'DEPANPAP', '26 avenue des locomotives', '59987', 'Coroncountry', 'Pollux', 5),
	(9180, 'HURRYTAPE', '68 boulevard des octets', '4044', 'Dumpville', 'Track', 0);

CREATE TABLE `produit` (
  `codart` char(4) NOT NULL,
  `libart` varchar(30) NOT NULL,
  `stkale` int(11) NOT NULL,
  `stkphy` int(11) NOT NULL,
  `qteann` int(11) NOT NULL,
  `unimes` char(5) NOT NULL,
  PRIMARY KEY (`codart`)
) ;


INSERT INTO `produit` (`codart`, `libart`, `stkale`, `stkphy`, `qteann`, `unimes`) VALUES
	('B001', 'Bande magnétique 1200', 20, 87, 240, 'unite'),
	('B002', 'Bande magnétique 6250', 20, 12, 410, 'unite'),
	('D035', 'CD R slim 80 mm', 40, 42, 150, 'B010'),
	('D050', 'CD R-W 80mm', 50, 4, 0, 'B010'),
	('I100', 'Papier 1 ex continu', 100, 557, 3500, 'B1000'),
	('I105', 'Papier 2 ex continu', 75, 5, 2300, 'B1000'),
	('I108', 'Papier 3 ex continu', 200, 557, 3500, 'B500'),
	('I110', 'Papier 4 ex continu', 10, 12, 63, 'B400'),
	('P220', 'Pré-imprimé commande', 500, 2500, 24500, 'B500'),
	('P230', 'Pré-imprimé facture', 500, 250, 12500, 'B500'),
	('P240', 'Pré-imprimé bulletin paie', 500, 3000, 6250, 'B500'),
	('P250', 'Pré-imprimé bon livraison', 500, 2500, 24500, 'B500'),
	('P270', 'Pré-imprimé bon fabrication', 500, 2500, 24500, 'B500'),
	('R080', 'ruban Epson 850', 10, 2, 120, 'unite'),
	('R132', 'ruban impl 1200 lignes', 25, 200, 182, 'unite');



CREATE TABLE `entcom` (
  `numcom` int(11) NOT NULL AUTO_INCREMENT,
  `obscom` varchar(50) DEFAULT NULL,
  `datcom` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `numfou` int(11) DEFAULT NULL,
  PRIMARY KEY (`numcom`),
  KEY `numfou` (`numfou`),
  CONSTRAINT `entcom_ibfk_1` FOREIGN KEY (`numfou`) REFERENCES `fournis` (`numfou`)
);


INSERT INTO `entcom` (`numcom`, `obscom`, `datcom`, `numfou`) VALUES
	(70010, '', '2018-04-23 15:59:51', 120),
	(70011, 'Commande urgente', '2018-04-23 15:59:51', 540),
	(70020, '', '2018-04-23 15:59:51', 9120),
	(70025, 'Commande urgente', '2018-04-23 15:59:51', 9150),
	(70210, 'Commande cadencée', '2018-04-23 15:59:51', 120),
	(70250, 'Commande cadencée', '2018-04-23 15:59:51', 8700),
	(70300, '', '2018-04-23 15:59:51', 9120),
	(70620, '', '2018-04-23 15:59:51', 540),
	(70625, '', '2018-04-23 15:59:51', 120),
	(70629, '', '2018-04-23 15:59:51', 9180);



CREATE TABLE `ligcom` (
  `numcom` int(11) NOT NULL,
  `numlig` tinyint(4) NOT NULL,
  `codart` char(4) NOT NULL,
  `qtecde` int(11) NOT NULL,
  `priuni` decimal(5,0) NOT NULL,
  `qteliv` int(11) DEFAULT NULL,
  `derliv` date NOT NULL,
  PRIMARY KEY (`numcom`,`numlig`),
  KEY `codart` (`codart`),
  CONSTRAINT `ligcom_ibfk_1` FOREIGN KEY (`numcom`) REFERENCES `entcom` (`numcom`),
  CONSTRAINT `ligcom_ibfk_2` FOREIGN KEY (`codart`) REFERENCES `produit` (`codart`)
);


INSERT INTO `ligcom` (`numcom`, `numlig`, `codart`, `qtecde`, `priuni`, `qteliv`, `derliv`) VALUES
	(70010, 1, 'I100', 3000, 470, 3000, '2007-03-15'),
	(70010, 2, 'I105', 2000, 485, 2000, '2007-07-05'),
	(70010, 3, 'I108', 1000, 680, 1000, '2007-08-20'),
	(70010, 4, 'D035', 200, 40, 250, '2007-02-20'),
	(70010, 5, 'P220', 6000, 3500, 6000, '2007-03-31'),
	(70010, 6, 'P240', 6000, 2000, 2000, '2007-03-31'),
	(70011, 1, 'I105', 1000, 600, 1000, '2007-05-16'),
	(70011, 2, 'P220', 10000, 3500, 10000, '2007-08-31'),
	(70020, 1, 'B001', 200, 140, 0, '2007-12-31'),
	(70020, 2, 'B002', 200, 140, 0, '2007-12-31'),
	(70025, 1, 'I100', 1000, 590, 1000, '2007-05-15'),
	(70025, 2, 'I105', 500, 590, 500, '2007-03-15'),
	(70210, 1, 'I100', 1000, 470, 1000, '2007-07-15'),
	(70250, 1, 'P230', 15000, 4900, 12000, '2007-12-15'),
	(70250, 2, 'P220', 10000, 3350, 10000, '2007-11-10'),
	(70300, 1, 'I100', 50, 790, 50, '2007-10-31'),
	(70620, 1, 'I105', 200, 600, 200, '2007-11-01'),
	(70625, 1, 'I100', 1000, 470, 1000, '2007-10-15'),
	(70625, 2, 'P220', 10000, 3500, 10000, '2007-10-31'),
	(70629, 1, 'B001', 200, 140, 0, '2007-12-31'),
	(70629, 2, 'B002', 200, 140, 0, '2007-12-31');



CREATE TABLE `vente` (
  `codart` char(4) NOT NULL,
  `numfou` int(11) NOT NULL,
  `delliv` smallint(6) NOT NULL,
  `qte1` int(11) NOT NULL,
  `prix1` decimal(5,0) NOT NULL,
  `qte2` int(11) DEFAULT NULL,
  `prix2` decimal(5,0) DEFAULT NULL,
  `qte3` int(11) DEFAULT NULL,
  `prix3` decimal(5,0) DEFAULT NULL,
  PRIMARY KEY (`codart`,`numfou`),
  KEY `numfou` (`numfou`),
  CONSTRAINT `vente_ibfk_1` FOREIGN KEY (`numfou`) REFERENCES `fournis` (`numfou`),
  CONSTRAINT `vente_ibfk_2` FOREIGN KEY (`codart`) REFERENCES `produit` (`codart`)
) ;


INSERT INTO `vente` (`codart`, `numfou`, `delliv`, `qte1`, `prix1`, `qte2`, `prix2`, `qte3`, `prix3`) VALUES
	('B001', 8700, 15, 0, 150, 50, 145, 100, 140),
	('B002', 8700, 15, 0, 210, 50, 200, 100, 185),
	('D035', 120, 0, 0, 40, 0, 0, 0, 0),
	('D035', 9120, 5, 0, 40, 100, 30, 0, 0),
	('I100', 120, 90, 0, 700, 50, 600, 120, 500),
	('I100', 540, 70, 0, 710, 60, 630, 100, 600),
	('I100', 9120, 60, 0, 800, 70, 600, 90, 500),
	('I100', 9150, 90, 0, 650, 90, 600, 200, 590),
	('I100', 9180, 30, 0, 720, 50, 670, 100, 490),
	('I105', 120, 90, 10, 705, 50, 630, 120, 500),
	('I105', 540, 70, 0, 810, 60, 645, 100, 600),
	('I105', 8700, 30, 0, 720, 50, 670, 100, 510),
	('I105', 9120, 60, 0, 920, 70, 800, 90, 700),
	('I105', 9150, 90, 0, 685, 90, 600, 200, 590),
	('I108', 120, 90, 5, 795, 30, 720, 100, 680),
	('I108', 9120, 60, 0, 920, 70, 820, 100, 780),
	('I110', 9120, 60, 0, 950, 70, 850, 90, 790),
	('I110', 9180, 90, 0, 900, 70, 870, 90, 835),
	('P220', 120, 15, 0, 3700, 100, 3500, 0, 0),
	('P220', 8700, 20, 50, 3500, 100, 3350, 0, 0),
	('P230', 120, 30, 0, 5200, 100, 5000, 0, 0),
	('P230', 8700, 60, 0, 5000, 50, 4900, 0, 0),
	('P240', 120, 15, 0, 2200, 100, 2000, 0, 0),
	('P250', 120, 30, 0, 1500, 100, 1400, 500, 1200),
	('P250', 9120, 30, 0, 1500, 100, 1400, 500, 1200),
	('R080', 9120, 10, 0, 120, 100, 100, 0, 0),
	('R132', 9120, 5, 0, 275, 0, 0, 0, 0);
