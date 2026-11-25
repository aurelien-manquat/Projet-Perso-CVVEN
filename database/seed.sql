USE cvven_materiel;

-- 1. Les 4 centres du CVVEN
INSERT INTO centre (nom, ville, adresse) VALUES
('Centre Paul Émile Victor', 'Les Rousses', 'Route du Lac, 39220 Les Rousses'),
('Village Océanique', 'La Rochelle', 'Avenue de la Plage, 17000 La Rochelle'),
('Centre des Volcans', 'Saint-Anthème', 'Lieu-dit La Loge, 63660 Saint-Anthème'),
('Domaine du Lac', 'Villefort', 'Route de Mende, 48800 Villefort');

-- 2. Les catégories de matériel
INSERT INTO categorie (libelle) VALUES
('Sports d''hiver'),
('Sports d''été & Plein air'),
('Audiovisuel & Colloques'),
('Informatique');

-- 3. Le catalogue des équipements
INSERT INTO equipement (libelle, description, categorie_id) VALUES
('Paire de skis alpins + bâtons', 'Skis polyvalents adultes, tailles variées', 1),
('Paire de raquettes à neige', 'Raquettes avec cale de montée', 1),
('VTT Adulte', 'VTT semi-rigide 27.5 pouces', 2),
('Vidéoprojecteur HD', 'Compatible PC/Mac avec câble HDMI', 3),
('PC Portable de prêt', 'Windows 10 avec suite Office installée', 4);

-- 4. Les stocks initiaux par centre
-- Les Rousses (id 1) a du matériel d'hiver et audiovisuel
INSERT INTO stock (centre_id, equipement_id, quantite_totale, quantite_pretable, etat) VALUES
(1, 1, 30, 20, 'bon'),
(1, 2, 25, 15, 'neuf'),
(1, 4, 3, 2, 'bon');

-- La Rochelle (id 2) a des VTT et des PC portables
INSERT INTO stock (centre_id, equipement_id, quantite_totale, quantite_pretable, etat) VALUES
(2, 3, 20, 12, 'bon'),
(2, 5, 10, 6, 'neuf');

-- 5. Utilisateurs de test (mot de passe en clair temporaire pour le test, on les hashera au Bloc 2)
INSERT INTO utilisateur (nom, email, mot_de_passe, role, centre_id) VALUES
('Jean Dupont (Resp. Rousses)', 'resp.rousses@cvven.fr', '1234', 'responsable', 1),
('Claire Martin (Agent Rousses)', 'agent.rousses@cvven.fr', '1234', 'agent', 1),
('Marc Leroy (Resp. Rochelle)', 'resp.rochelle@cvven.fr', '1234', 'responsable', 2),
('Admin National', 'admin@cvven.fr', 'admin123', 'admin', 1);