CREATE DATABASE IF NOT EXISTS cvven_materiel CHARACTER SET utf8mb4; USE cvven_materiel;

CREATE TABLE centre (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  ville VARCHAR(100) NOT NULL,
  adresse VARCHAR(255)
);

CREATE TABLE utilisateur (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  mot_de_passe VARCHAR(255) NOT NULL,
  role ENUM('agent','responsable','admin') NOT NULL,
  centre_id INT NOT NULL,
  FOREIGN KEY (centre_id) REFERENCES centre(id)
);

CREATE TABLE categorie (
  id INT AUTO_INCREMENT PRIMARY KEY,
  libelle VARCHAR(100) NOT NULL
);

CREATE TABLE equipement (
  id INT AUTO_INCREMENT PRIMARY KEY,
  libelle VARCHAR(150) NOT NULL,
  description TEXT,
  categorie_id INT NOT NULL,
  FOREIGN KEY (categorie_id) REFERENCES categorie(id)
);

CREATE TABLE stock (
  centre_id INT NOT NULL,
  equipement_id INT NOT NULL,
  quantite_totale INT NOT NULL DEFAULT 0,
  quantite_pretable INT NOT NULL DEFAULT 0,
  etat ENUM('neuf','bon','usage','a_reparer') NOT NULL DEFAULT 'bon',
  PRIMARY KEY (centre_id, equipement_id),
  FOREIGN KEY (centre_id) REFERENCES centre(id),
  FOREIGN KEY (equipement_id) REFERENCES equipement(id),
  CHECK (quantite_pretable <= quantite_totale)
);

CREATE TABLE pret (
  id INT AUTO_INCREMENT PRIMARY KEY,
  centre_preteur_id INT NOT NULL,
  centre_emprunteur_id INT NOT NULL,
  demandeur_id INT NOT NULL,
  date_demande DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  date_debut DATE NOT NULL,
  date_fin DATE NOT NULL,
  statut ENUM('demande','accepte','refuse','expedie','recu','retourne','cloture')
         NOT NULL DEFAULT 'demande',
  FOREIGN KEY (centre_preteur_id) REFERENCES centre(id),
  FOREIGN KEY (centre_emprunteur_id) REFERENCES centre(id),
  FOREIGN KEY (demandeur_id) REFERENCES utilisateur(id),
  CHECK (centre_preteur_id <> centre_emprunteur_id),
  CHECK (date_fin >= date_debut)
);

CREATE TABLE ligne_pret (
  pret_id INT NOT NULL,
  equipement_id INT NOT NULL,
  quantite INT NOT NULL,
  etat_envoi ENUM('neuf','bon','usage','a_reparer'),
  etat_retour ENUM('neuf','bon','usage','a_reparer'),
  PRIMARY KEY (pret_id, equipement_id),
  FOREIGN KEY (pret_id) REFERENCES pret(id),
  FOREIGN KEY (equipement_id) REFERENCES equipement(id),
  CHECK (quantite > 0)
);