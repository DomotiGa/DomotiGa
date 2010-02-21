-- MySQL dump 10.13  Distrib 5.1.37, for debian-linux-gnu (i486)
--
-- Host: localhost    Database: domotiga
-- ------------------------------------------------------
-- Server version	5.1.37-1ubuntu5.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

USE domotiga;

DROP TABLE IF EXISTS `tvchannels`;

UPDATE menu SET enabled = TRUE WHERE id = 17;

--
-- Table structure for table `tv_channels`
--

DROP TABLE IF EXISTS `tv_channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tv_channels` (
  `RecID` int(11) NOT NULL AUTO_INCREMENT,
  `ChannelName` varchar(50) NOT NULL,
  `ChannelID` varchar(25) NOT NULL,
  `BLOBlogo` longblob NOT NULL,
  `EXTlogo` varchar(5) NOT NULL,
  `CreationDate` char(12) NOT NULL,
  `ModificationDate` char(12) NOT NULL,
  `FK_Users` int(1) NOT NULL,
  `IsUpdated` tinyint(4) NOT NULL,
  `IsUsed` int(11) NOT NULL,
  `ChannelOrder` char(4) NOT NULL,
  PRIMARY KEY (`RecID`)
) ENGINE=MyISAM AUTO_INCREMENT=403 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tv_categories`
--

DROP TABLE IF EXISTS `tv_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tv_categories` (
  `RecID` int(11) NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(50) NOT NULL,
  `BackColor` varchar(15) NOT NULL,
  `ForeColor` varchar(15) NOT NULL,
  `BLOBpreview` longblob NOT NULL,
  `EXTpreview` varchar(5) NOT NULL,
  `CreationDate` char(12) NOT NULL,
  `ModificationDate` char(12) NOT NULL,
  `FK_Users` int(11) NOT NULL,
  `IsUpdated` tinyint(4) NOT NULL,
  PRIMARY KEY (`RecID`)
) ENGINE=MyISAM AUTO_INCREMENT=131 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tv_subcategories`
--

DROP TABLE IF EXISTS `tv_subcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tv_subcategories` (
  `RecID` int(11) NOT NULL AUTO_INCREMENT,
  `CategoryID` varchar(50) NOT NULL,
  `SubCategoryName` varchar(50) NOT NULL,
  `CreationDate` char(12) NOT NULL,
  `ModificationDate` char(12) NOT NULL,
  `FK_Users` int(11) NOT NULL,
  `IsUpdated` tinyint(4) NOT NULL,
  PRIMARY KEY (`RecID`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tv_programs`
--

DROP TABLE IF EXISTS `tv_programs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tv_programs` (
  `ChannelID` varchar(25) NOT NULL,
  `StartPoint` char(12) NOT NULL,
  `EndPoint` char(12) NOT NULL,
  `ProgramName` varchar(150) NOT NULL,
  `ProgramDescription` varchar(1000) NOT NULL,
  `CategoryName` varchar(50) NOT NULL,
  `SubCategoryName` varchar(50) NOT NULL,
  `CreationDate` char(12) NOT NULL,
  `FK_Users` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dictionary`
--

DROP TABLE IF EXISTS `dictionary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dictionary` (
  `RecID` int(11) NOT NULL AUTO_INCREMENT,
  `US` varchar(500) NOT NULL,
  `NL` varchar(500) NOT NULL,
  `DE` varchar(500) NOT NULL,
  `FR` varchar(500) NOT NULL,
  `CreationDate` char(12) NOT NULL,
  `ModificationDate` char(12) NOT NULL,
  `FK_Users` int(11) NOT NULL,
  PRIMARY KEY (`RecID`)
) ENGINE=MyISAM AUTO_INCREMENT=370 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dictionary`
--

LOCK TABLES `dictionary` WRITE;
/*!40000 ALTER TABLE `dictionary` DISABLE KEYS */;
INSERT INTO `dictionary` VALUES (127,'version','versie','Version','version','201002131249','201002131249',1),(129,'Login','Inloggen','Anmeldung','Connexion','201002131249','201002131249',1),(130,'Password','Wachtwoord','Passwort','Mot de passe','201002131249','201002131249',1),(131,'User not found !','Gebruiker niet gevonden!','User nicht gefunden!','L`utilisateur pas trouvé!','201002131249','201002131306',1),(132,'Filter','Filter','Filter','Filtre','201002131249','201002131249',1),(133,'View','Bekijk','Anzeigen','Affichage','201002131249','201002131252',1),(134,'First Name','Voornaam','Vorname','Prénom','201002131249','201002131249',1),(135,'Last Name','Achternaam','Nachname','Nom de famille','201002131249','201002131249',1),(136,'Home Email','HuisEmail','Heim Email','Maison Email','201002131249','201002131255',1),(137,'Home Telephone','Huistelefoon','Home Telefon','Téléphone à la maison','201002131249','201002131249',1),(138,'Home Mobile Phone','HuisGSM','Heim Handy','Maison GSM','201002131249','201002131256',1),(139,'Resultset','Resultaat','Ergebnismenge','ResultSet','201002131249','201002131257',1),(140,'Commands','Commando','Befehle','Commandes','201002131249','201002131249',1),(141,'Add','Toevoegen','Hinzufügen','Ajouter','201002131249','201002131249',1),(142,'Modify','Wijzigen','Ändern','Modifier','201002131249','201002131249',1),(143,'Copy','Kopiëren','Kopieren','Copier','201002131249','201002131249',1),(144,'Delete','Wissen','Löschen','Supprimer','201002131249','201002131249',1),(145,'Print','Afdrukken','Drucken','Imprimer','201002131249','201002131249',1),(146,'Select','Selecteer','Wählen Sie','Sélectionnez','201002131249','201002131249',1),(147,'Description','Beschrijving','Beschreibung','Description','201002131249','201002131249',1),(148,'Extension','Uitbreiding','Verlängerung','Extension','201002131249','201002131249',1),(149,'Remark','Opmerking','Bemerkung','Remarque','201002131249','201002131249',1),(150,'Last Modified','Laatst gewijzigd','Zuletzt geändert','Dernière mise à jour','201002131249','201002131249',1),(151,'Modified By','Gewijzigd door','Geändert von','Modifié par','201002131249','201002131249',1),(152,'US','US','US','US','201002131249','201002131307',1),(153,'NL','NL','NL','NL','201002131249','201002131249',1),(154,'DE','DE','DE','DE','201002131249','201002131249',1),(155,'FR','FR','FR','FR','201002131249','201002131249',1),(156,'Zipcode','Postcode','PLZ','Code postal','201002131249','201002131249',1),(157,'City','Stad','Stadt','Ville','201002131249','201002131249',1),(158,'Country','Land','Land','Pays','201002131249','201002131249',1),(159,'Name','Naam','Name','Nom','201002131249','201002131249',1),(160,'Street','Straat','Straße','Rue','201002131249','201002131257',1),(162,'Logged in as','Ingelogd als','Angemeldet als','Connecté en tant que','201002131249','201002131249',1),(163,'Settings','Instellingen','Einstellungen','Paramètres','201002131249','201002131249',1),(164,'Menu - Definition','Menu - Definitie','Menü - Definition','Menu - Définition','201002131249','201002131249',1),(165,'Cities - Administrate','Steden - Beheren','Städte - Verwalten','Villes - Administrer','201002131249','201002131249',1),(166,'Users - Administrate','Gebruikers - Beheren','Benutzer - Verwalten','Utilisateurs - Administrer','201002131249','201002131249',1),(167,'Icons - Library','Iconen - Bibliotheek','Icons - Bibliothek','Icônes - Bibliothèque','201002131249','201002131257',1),(168,'Dictionary','Woordenboek','Wörterbuch','Dictionnaire','201002131249','201002131249',1),(169,'Weather','Weer','Wetter','Temps','201002131249','201002131249',1),(170,'General','Algemeen','General','Général','201002131249','201002131249',1),(172,'Members - Administrate','Leden - Beheren','Mitglieder - Administration','Membres - Administrer','201002131249','201002131249',1),(173,'Your query results in more then 1000 items, continue ?','Uw zoekopdracht resulteert in meer dan 1000 artikelen, doorgaan?','Ihre Abfrage-Ergebnisse in mehr als 1000 Artikel, fortfahren?','Les résultats de votre requête dans plus de 1000 articles, continuer?','201002131250','201002131250',1),(174,'Yes','Ja','Ja','Oui','201002131250','201002131250',1),(175,'No','Nee','Nein','Non','201002131250','201002131250',1),(176,'Data','Data','Data','Data','201002131250','201002131250',1),(177,'By','Door','Von','Par','201002131250','201002131250',1),(178,'ID','ID','ID','ID','201002131250','201002131250',1),(179,'Created / Modified','Aangemaakt / Gewijzigd','Erstellt / Geändert','Créé / jour','201002131250','201002131250',1),(180,'Cancel','Annuleren','Abbrechen','Annuler','201002131250','201002131250',1),(181,'OK','OK','OK','OK','201002131250','201002131250',1),(182,'Street / Number','Straat / huisnummer','Straße / Hausnummer','Rue / Numéro','201002131251','201002131251',1),(183,'Zipcode / City','Postcode / Plaats','PLZ / Ort','Code postal / Ville','201002131251','201002131251',1),(184,'Website','Website','Website','Site','201002131251','201002131251',1),(185,'Birthday','Verjaardag','Geburtsdatum Tag','Jour de naissance','201002131251','201002131253',1),(186,'Browse','Bladeren','Navigieren','Parcourir','201002131251','201002131251',1),(187,'Clear','Wis','Klar','Clair','201002131251','201002131251',1),(188,'Personal','Persoonlijk','Personal','Personal','201002131251','201002131251',1),(189,'Repeat Password','Herhaal wachtwoord','Passwort wiederholen','Répéter Mot de passe','201002131251','201002131251',1),(190,'Home','Thuis','Heim','Maison','201002131251','201002131254',1),(191,'Telephone','Telefoon','Telefon','Téléphone','201002131251','201002131251',1),(192,'Mobile Phone','Mobiele Telefoon','Handy','Mobile Phone','201002131251','201002131251',1),(193,'Fax','Fax','Fax','Fax','201002131251','201002131251',1),(194,'Email','Email','E-Mail','Email','201002131251','201002151545',1),(195,'Work','Werk','Arbeit','Travailler','201002131251','201002131251',1),(196,'Send','Sturen','Senden','Envoyer','201002131251','201002131251',1),(197,'Server Name','Servernaam','Server Name','Nom du serveur','201002131251','201002131251',1),(198,'Server Port','Serverpoort','Server Port','Port du serveur','201002131251','201002131251',1),(199,'Encryption','Encryptie','Verschlüsselung','Cryptage','201002131251','201002131251',1),(200,'Server Protocol','Server Protocol','Server-Protokoll','Protocole du serveur','201002131251','201002131251',1),(201,'Receive','Ontvang','Empfangen','Recevoir','201002131251','201002131251',1),(202,'Communication','Communicatie','Mitteilung','Communication','201002131251','201002131251',1),(203,'Translate from internet','Vertalen van internet','Übersetzen von Internet','Traduire de l`internet','201002131251','201002131306',1),(204,'Weatherbug ID','WeatherBug ID','Weatherbug ID','WeatherBug ID','201002131407','201002131407',1),(205,'City Code','Stad Code','Stadt Code','Code de ville','201002131407','201002131435',1),(206,'Search','Zoeken','Suche','Recherche','201002131441','201002131441',1),(207,'Preview','Voorbeeld','Vorschau','Preview','201002131441','201002161840',1),(208,'Live Weather','Live Weer','Live Wetter','Météo Live','201002131442','201002151546',1),(209,'Weather Forecast','Weersvoorspelling','Wettervorhersage','Prévisions météorologiques','201002131442','201002131442',1),(210,'dew-point temperature:','dauwpunt temperatuur:','Taupunkttemperatur:','point de rosée:','201002131532','201002131532',1),(211,'Feels-like temperature:','Gevoels-temperatuur:','Feels-like Temperatur:','Se sent-comme la température:','201002131532','201002131609',1),(212,'Wind direction:','Windrichting:','Windrichtung:','Direction du vent:','201002131532','201002131532',1),(213,'Wind speed:','Windsnelheid:','Windgeschwindigkeit:','Vitesse du vent:','201002131532','201002131532',1),(214,'km/h','km/u','km/u','km/h','201002131532','201002131752',1),(215,'Humidity:','Vochtigheid:','Luftfeuchtigkeit:','Humidité:','201002131540','201002131540',1),(216,'Humidity (high):','Vochtigheid (hoog):','Luftfeuchtigkeit (hoch):','Humidité (élevé):','201002131540','201002131540',1),(217,'Humidity (low):','Vochtigheid (laag):','Luftfeuchtigkeit (niedrig):','Humidité (faible):','201002131540','201002131540',1),(218,'Pressure:','Druk:','Druck:','Pression:','201002131608','201002131608',1),(219,'Pressure (high):','Druk (hoog):','Druck (hoch):','(Haute pression):','201002131608','201002131608',1),(220,'Pressure (low):','Druk (laag):','Druck (niedrig):','Pression (faible):','201002131608','201002131610',1),(221,'Rain (this month):','Regen (deze maand):','Regen (in diesem Monat):','Pluie (ce mois-ci):','201002131608','201002132255',1),(222,'Rain (today):','Regen (vandaag):','Regen (heute):','Pluie (aujourd`hui):','201002131608','201002132255',1),(223,'Rain (this year):','Regen (dit jaar):','Regen (dieses Jahr):','Pluie (cette année):','201002131608','201002132255',1),(224,'Maximum:','Maximum:','Maximum:','Maximum:','201002131608','201002131608',1),(225,'Minimum:','Minimum:','Minimum:','Minimum:','201002131608','201002131608',1),(226,'Sunrise:','Zonsopgang:','Sonnenaufgang:','Lever du soleil:','201002131619','201002131619',1),(227,'Sunset:','Zonsondergang:','Sonnenuntergang:','Coucher du soleil:','201002131619','201002131619',1),(228,'Incorrect password !','Onjuist wachtwoord!','Falsches Passwort!','Mot de passe incorrect!','201002131702','201002131702',1),(229,'Wind gust direction:','Wind-vlagen richting:','Windböe Richtung:','Des rafales de vent de direction:','201002131751','201002131753',1),(230,'Wind gust speed:','Wind-vlagen snelheid:','Wind Windspitze:','Des rafales de vent de vitesse:','201002131751','201002131753',1),(344,'Date','Datum','Datum','Date','201002151626','201002151626',1),(345,'TV Channels','TV-kanalen','TV-Kanäle','Chaînes TV','201002151927','201002151927',1),(346,'Program Categories','Programma Categorieën','Programm-Kategorien','Catégories de Programmes','201002151927','201002151927',1),(232,'Average','Gemiddeld','Durchschnitt','Moyenne','201002131759','201002131759',1),(233,'Moon','Maan','Mond','Lune','201002131759','201002131759',1),(248,'Satellite images','Satellietbeelden','Satellitenbilder','Images satellite','201002141033','201002141033',1),(235,'Access Denied to given URL !','Toegang geweigerd tot bepaalde URL!','Zugang zu den angegebenen URL verweigert!','Accès refusé à l`URL donnée!','201002132040','201002132254',1),(236,'Sunday','Zondag','Sonntag','Dimanche','201002132221','201002132221',1),(237,'Monday','Maandag','Montag','Lundi','201002132221','201002132221',1),(238,'Tuesday','Dinsdag','Dienstag','Mardi','201002132221','201002132221',1),(239,'Wednesday','Woensdag','Mittwoch','Mercredi','201002132221','201002132221',1),(240,'Thursday','Donderdag','Donnerstag','Jeudi','201002132221','201002132221',1),(241,'Friday','Vrijdag','Freitag','Vendredi','201002132221','201002132221',1),(242,'Saturday','Zaterdag','Samstag','Samedi','201002132221','201002132221',1),(243,'High:','Hoog:','Hoch:','High:','201002132224','201002132225',1),(244,'Low:','Laag:','Niedrig:','Low:','201002132224','201002132225',1),(249,'Satellite','Satelliet','Satellite','Satellite','201002141041','201002141041',1),(250,'Image files','Afbeeldingsbestanden','Image-Dateien','Les fichiers d`image','201002141644','201002151547',1),(251,'Please select an image ...','Selecteer een afbeelding ...','Bitte wählen Sie ein Bild ...','S`il vous plaît sélectionnez une image ...','201002141644','201002151549',1),(252,'TV Guide','TV Gids','TV Guide','TV Guide','201002141647','201002141647',1),(253,'XML Grab Command','XML Grab Command','XML Grab Command','XML Grab Command','201002141925','201002141925',1),(254,'Info','Info','Info','Info','201002141925','201002141925',1),(255,'Grab','Grab','Grab','Grab','201002141925','201002141925',1),(256,'XML File Location','XML-bestand Locatie','XML-File Location','Emplacement du fichier XML','201002141925','201002141925',1),(271,'News','Nieuws','News','Nouvelles','201002151520','201002151520',1),(272,'Series','Series','Serie','Série','201002151520','201002151520',1),(273,'Interests','Interesses','Interessen','Centres d`intérêt','201002151520','201002151548',1),(274,'Sport','Sport','Sport','Sport','201002151520','201002151520',1),(258,'EPG - Valid from:','EPG - Geldig van:','EPG - gültig ab:','EPG - Valable à partir de:','201002142026','201002142026',1),(259,'EPG - Valid until:','EPG - Geldig tot:','EPG - Gültig bis:','EPG - Valide jusqu`au:','201002142026','201002151547',1),(260,'Identifier:','Identifier:','Identifier:','Identifier:','201002142026','201002142026',1),(261,'Summary:','Samenvatting:','Zusammenfassung:','Résumé:','201002142026','201002142026',1),(262,'Channels and','Kanalen en','Kanäle und','Chaînes et','201002151234','201002151234',1),(263,'Programs found !','Programmas gevonden!','Programme gefunden!','Programmes trouvés!','201002151234','201002151320',1),(264,'Downloading XML file ...','XML-bestand downloaden ...','XML-Datei herunter zu laden ...','Téléchargement de fichier XML ...','201002151306','201002151306',1),(265,'Parsing XML file ...','Verwerken XML-bestand ...','Parsen von XML-Datei ...','L`analyse du fichier XML ...','201002151307','201002151547',1),(278,'Current Affairs','Actualiteit','Current Affairs','Faits et événements','201002151520','201002151542',1),(279,'Documentary','Documentaire','Dokumentarfilm','Documentaire','201002151520','201002151520',1),(275,'Shows','Shows','Shows','Spectacles','201002151520','201002151520',1),(276,'Varia','Varia','Varia','Varia','201002151520','201002151520',1),(277,'Game Show','Spelshow','Game Show','Game Show','201002151520','201002151520',1),(270,'It can take a few minutes before the download and processing is completed, continue ?','Het kan een paar minuten duren voordat de download en de verwerking is voltooid, doorgaan?','Es kann einige Minuten dauern, bevor der Download und die Verarbeitung beendet ist, fahren Sie?','Il peut s`écouler quelques minutes avant le téléchargement et le traitement terminé, continuer?','201002151318','201002151548',1),(280,'Natural World','Natural World','Natural World','Natural World','201002151520','201002151520',1),(281,'Crime','Misdaad','Crime','Crime','201002151520','201002151542',1),(282,'Drama','Drama','Drama','Drame','201002151520','201002151520',1),(283,'Cookery','Kokkerellen','Cookery','Cookery','201002151520','201002151542',1),(284,'Winter Sports','Wintersport','Wintersport','Sports d`hiver','201002151520','201002151549',1),(285,'Reality TV','Reality TV','Reality TV','Reality TV','201002151520','201002151520',1),(286,'Football','Voetbal','Fußball','Football','201002151520','201002151520',1),(287,'Film','Film','Film','Film','201002151520','201002151520',1),(288,'Children','Kinderen','Kinder','Enfants','201002151520','201002151520',1),(289,'Music & Arts','Muziek & kunst','Musik & Kunst','Music & Arts','201002151520','201002151545',1),(290,'Religious','Religieus','Religious','Religieux','201002151520','201002151520',1),(291,'Comedy','Komedie','Comedy','Comédie','201002151520','201002151542',1),(292,'Business','Zakelijk','Geschäft','Entreprise','201002151520','201002151555',1),(293,'Cricket','Cricket','Cricket','Cricket','201002151520','201002151520',1),(294,'Movie','Film','Movie','Movie','201002151520','201002151520',1),(295,'Animation','Animatie','Animation','Animation','201002151520','201002151520',1),(296,'Drama Series','Dramaserie','Drama-Serie','Série dramatique','201002151520','201002151520',1),(297,'Entertainment','Entertainment','Entertainment','Divertissement','201002151520','201002151520',1),(298,'Magazine','Magazine','Magazine','Magazine','201002151520','201002151520',1),(299,'Jazz','Jazz','Jazz','Jazz','201002151520','201002151520',1),(300,'Classical Music','Klassieke Muziek','Klassische Musik','Musique classique','201002151520','201002151520',1),(301,'Pop and Rock','Pop en Rock','Pop-und Rock','Pop et Rock','201002151520','201002151520',1),(302,'Action','Actie','Action','Action','201002151520','201002151520',1),(303,'Education','Onderwijs','Bildung','Education','201002151520','201002151520',1),(304,'Science Fiction','Sciencefiction','Science Fiction','Science Fiction','201002151520','201002151520',1),(305,'Fantasy','Fantasie','Fantasy','Fantasy','201002151520','201002151543',1),(306,'Adult','Volwassen','Adult','Adulte','201002151520','201002151541',1),(307,'Horror','Horror','Horror','Horreur','201002151520','201002151520',1),(308,'Cinema','Bioscoop','Kino','Cinéma','201002151520','201002151541',1),(309,'Fashion','Mode','Mode','Mode','201002151520','201002151520',1),(310,'Architecture','Architectuur','Architektur','Architecture','201002151520','201002151520',1),(311,'Science','Wetenschap','Wissenschaft','Science','201002151520','201002151520',1),(312,'Athletics','Atletiek','Leichtathletik','Athlétisme','201002151520','201002151520',1),(313,'Health','Gezondheid','Gesundheit','Santé','201002151520','201002151520',1),(314,'Travel','Reizen','Reisen','Voyage','201002151520','201002151520',1),(315,'Consumer','Consument','Consumer','Consommateurs','201002151520','201002151520',1),(316,'Environment','Omgeving','Umgebung','Environnement','201002151520','201002151520',1),(317,'History','Geschiedenis','Geschichte','Histoire','201002151520','201002151520',1),(318,'Antiques','Antiek','Antiquitäten','Antiquités','201002151520','201002151520',1),(319,'Gardening','Tuinieren','Gardening','Jardinage','201002151520','201002151520',1),(320,'Motor Sports','Motorsport','Motor Sports','Sports automobiles','201002151520','201002151520',1),(321,'Art','Kunst','Kunst','Art','201002151520','201002151541',1),(322,'Ballet','Ballet','Ballett','Ballet','201002151520','201002151520',1),(323,'Opera','Opera','Opera','Opera','201002151520','201002151520',1),(324,'Dancing','Dansen','Dancing','Dancing','201002151520','201002151543',1),(325,'Leisure','Vrije tijd','Freizeit','Loisirs','201002151521','201002151546',1),(326,'Shopping','Winkelen','Shopping','Shopping','201002151521','201002151521',1),(327,'Film Shorts','Kortfilm','Film Shorts','Film Shorts','201002151521','201002151545',1),(328,'Equestrian','Paardensport','Pferdesport','Sports équestres','201002151521','201002151521',1),(329,'Civilisation','Beschaving','Civilisation','Civilisation','201002151521','201002151542',1),(330,'Stage Play','Toneelstuk','Sprechtheater','Pièce de théâtre','201002151521','201002151521',1),(331,'War','Oorlog','War','Guerre','201002151521','201002151521',1),(332,'Classic','Klassiek','Classic','Classic','201002151521','201002151542',1),(333,'Sitcoms','Sitcoms','Sitcoms','Sitcoms','201002151521','201002151521',1),(334,'Youth Culture','Jeugd Cultuur','Jugend Kultur','Youth Culture','201002151521','201002151521',1),(335,'Dance Music','Dans muziek','Dance Music','Dance Music','201002151522','201002151543',1),(336,'Talk Show','Praatprogramma','Talk Show','Talk Show','201002151522','201002151544',1),(337,'Martial Arts','Vechtsport','Martial Arts','Arts Martiaux','201002151522','201002151522',1),(338,'Golf','Golf','Golf','Golf','201002151522','201002151522',1),(339,'Processing Categories ...','Verwerking rubrieken ...','Processing Kategorien ...','Traitement de catégories ...','201002151523','201002151523',1),(340,'Processing SubCategories ...','Verwerking SubCategories ...','Processing SubCategories ...','Sous-catégories de traitement ...','201002151523','201002151523',1),(341,'Channels','Kanalen','Kanäle','Chaînes','201002151523','201002151523',1),(342,'Main Categories and','Hoofdcategorieën en','Hauptkategorien und','Principales catégories et','201002151523','201002151523',1),(343,'Programs processed !','Programmas verwerkt!','Programme bearbeitet!','Programmes traités!','201002151523','201002151553',1),(347,'Use','Gebruiken','Verwenden','Utiliser','201002152032','201002152032',1),(348,'Channel Name','Kanaal Naam','Channel Name','Channel Name','201002152032','201002152032',1),(351,'Sorting Order','Volgorde','Sortierreihenfolge','Lu0026#39;ordre de tri','201002152034','201002152034',1),(350,'Program Sub-Categories','Programma Sub-Categorieën','Programm Sub-Kategorien','Sous-Catégories','201002152032','201002152032',1),(352,'Program','Programma','Programm','Programme','201002152120','201002152120',1),(353,'Category','Categorie','Kategorie','Catégorie','201002152120','201002152120',1),(354,'Sub-Category','Subcategorie','Sub-Kategorie','Sous-catégorie','201002152120','201002152120',1),(355,'Summary','Samenvatting','Zusammenfassung','Sommaire','201002152120','201002152120',1),(356,'Channel ID','Kanaal ID','Sender ID','ID de canal','201002161152','201002161830',1),(357,'Category Name','Categorienaam','Kategorie Name','Nom de la catégorie','201002161514','201002161829',1),(358,'Back Color','Achtergrondkleur','Zurück Farbe','Couleur d`arrière','201002161515','201002161829',1),(359,'Fore Color','Voorgrondkleur','Textfarbe','Fore Color','201002161516','201002161831',1),(360,'Select Color','Selecteer kleur','Farbe auswählen','Sélectionner la couleur','201002161556','201002161830',1),(361,'Please select a foreground color ...','Selecteer een voorgrondkleur ...','Bitte wählen Sie eine Vordergrundfarbe ...','S`il vous plaît choisir une couleur de premier plan ...','201002161620','201002161831',1),(362,'Please select a background color ...','Kies een achtergrond kleur ...','Bitte wählen Sie eine Hintergrundfarbe ...','S`il vous plaît sélectionnez une couleur de fond ...','201002161620','201002161830',1),(363,'Program Name','Programmanaam','Programmname','Nom du programme','201002162120','201002162120',1),(364,'Begins at ...','Begint om ...','Beginnt am ...','Commence à ...','201002162120','201002162127',1),(365,'Ends at ...','Eindigt om ...','Endet am ...','Se termine à ...','201002162120','201002162128',1),(366,'Program Description','Programma Beschrijving','Programmbeschreibung','Description du programme','201002171814','201002171814',1),(367,'Channel','Kanaal','Channel','Channel','201002171815','201002171815',1),(368,'Results for search [','Resultaten voor zoeken [','Ergebnisse für die Suche [','Résultats pour la recherche [','201002171815','201002171815',1),(369,'In the period','In de periode','In der Zeit','Dans la période','201002171815','201002171815',1);
/*!40000 ALTER TABLE `dictionary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `version`
--

DROP TABLE IF EXISTS `version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `db` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
/*!40000 ALTER TABLE `version` DISABLE KEYS */;
INSERT INTO `version` VALUES (1,'0.1.166'),(2,'0.1.167'),(3,'0.1.168'),(4,'0.1.169'),(5,'0.1.170'),(6,'0.1.171'),(7,'0.1.172'),(8,'0.1.173'),(9,'0.1.174'),(10,'0.1.175'),(11,'0.1.176'),(12,'0.1.177'),(13,'0.1.178'),(14,'0.1.179'),(15,'0.1.180'),(16,'0.1.181'),(17,'0.1.182'),(18,'0.1.183');
/*!40000 ALTER TABLE `version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_tvguide`
--

DROP TABLE IF EXISTS `settings_tvguide`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_tvguide` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `xmlgrabcmd` text,
  `xmlfile` text,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_tvguide`
--

LOCK TABLES `settings_tvguide` WRITE;
/*!40000 ALTER TABLE `settings_tvguide` DISABLE KEYS */;
INSERT INTO `settings_tvguide` VALUES (0,0,'/home/ron/domotiga/tvguide/mc2xml -c nl -g 1000 -D /home/ron/domotiga/tvguide/mc2xml.dat -o /home/ron/domotiga/tvguide/tvguide.xml','/home/ron/domotiga/tvguide/tvguide.xml',0),(1,0,'/home/ron/domotiga/tvguide/mc2xml -c nl -g 3318 -D /home/ron/domotiga/tvguide/mc2xml.dat -o /home/ron/domotiga/tvguide/tvguide.xml','/home/ron/domotiga/tvguide/tvguide.xml',0);
/*!40000 ALTER TABLE `settings_tvguide` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_weatherbug`
--

DROP TABLE IF EXISTS `settings_weatherbug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_weatherbug` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `weatherbugid` varchar(32) DEFAULT NULL,
  `city` varchar(128) DEFAULT NULL,
  `citycode` varchar(32) DEFAULT NULL,
  `countryname` varchar(32) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_weatherbug`
--

LOCK TABLES `settings_weatherbug` WRITE;
/*!40000 ALTER TABLE `settings_weatherbug` DISABLE KEYS */;
INSERT INTO `settings_weatherbug` VALUES (0,0,'A1234567890','Dordrecht','71092','Netherlands',0),(1,0,'A1234567890','Dordrecht','71092','Netherlands',0);
/*!40000 ALTER TABLE `settings_weatherbug` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-02-21 12:30:55
