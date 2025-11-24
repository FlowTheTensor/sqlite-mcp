-- Schul-Datenbank für MCP Server Demo
-- Erstellt: 24. November 2025

-- Tabelle: Schueler
CREATE TABLE schueler (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    vorname TEXT NOT NULL,
    nachname TEXT NOT NULL,
    klasse TEXT NOT NULL,
    geburtsdatum DATE,
    email TEXT
);

-- Tabelle: Lehrer
CREATE TABLE lehrer (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    vorname TEXT NOT NULL,
    nachname TEXT NOT NULL,
    fach TEXT NOT NULL,
    raum TEXT
);

-- Tabelle: Kurse
CREATE TABLE kurse (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    kursname TEXT NOT NULL,
    lehrer_id INTEGER,
    raum TEXT,
    wochentag TEXT,
    uhrzeit TEXT,
    FOREIGN KEY (lehrer_id) REFERENCES lehrer(id)
);

-- Tabelle: Noten
CREATE TABLE noten (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    schueler_id INTEGER NOT NULL,
    kurs_id INTEGER NOT NULL,
    note REAL NOT NULL,
    datum DATE,
    art TEXT, -- z.B. "Klausur", "mündlich", "Hausaufgabe"
    FOREIGN KEY (schueler_id) REFERENCES schueler(id),
    FOREIGN KEY (kurs_id) REFERENCES kurse(id)
);

-- Beispieldaten: Schüler
INSERT INTO schueler (vorname, nachname, klasse, geburtsdatum, email) VALUES
('Max', 'Mustermann', '10a', '2009-03-15', 'max.mustermann@schule.de'),
('Anna', 'Schmidt', '10a', '2009-07-22', 'anna.schmidt@schule.de'),
('Tom', 'Weber', '10b', '2009-01-10', 'tom.weber@schule.de'),
('Lisa', 'Meyer', '10a', '2009-05-30', 'lisa.meyer@schule.de'),
('Paul', 'Fischer', '10b', '2009-11-08', 'paul.fischer@schule.de'),
('Sarah', 'Becker', '11a', '2008-04-17', 'sarah.becker@schule.de'),
('Leon', 'Schulz', '11a', '2008-09-25', 'leon.schulz@schule.de'),
('Emma', 'Wagner', '11b', '2008-02-14', 'emma.wagner@schule.de'),
('Jonas', 'Hoffmann', '11b', '2008-12-03', 'jonas.hoffmann@schule.de'),
('Mia', 'Koch', '12a', '2007-06-20', 'mia.koch@schule.de');

-- Beispieldaten: Lehrer
INSERT INTO lehrer (vorname, nachname, fach, raum) VALUES
('Petra', 'Müller', 'Mathematik', 'A101'),
('Thomas', 'Klein', 'Informatik', 'B205'),
('Sandra', 'Wolf', 'Deutsch', 'A203'),
('Michael', 'Schneider', 'Englisch', 'C102'),
('Julia', 'Zimmermann', 'Physik', 'B110');

-- Beispieldaten: Kurse
INSERT INTO kurse (kursname, lehrer_id, raum, wochentag, uhrzeit) VALUES
('Mathematik Grundkurs', 1, 'A101', 'Montag', '08:00'),
('Informatik Leistungskurs', 2, 'B205', 'Dienstag', '10:00'),
('Deutsch Grundkurs', 3, 'A203', 'Mittwoch', '09:00'),
('Englisch Grundkurs', 4, 'C102', 'Donnerstag', '11:00'),
('Physik Leistungskurs', 5, 'B110', 'Freitag', '08:00');

-- Beispieldaten: Noten
INSERT INTO noten (schueler_id, kurs_id, note, datum, art) VALUES
-- Max Mustermann
(1, 1, 2.3, '2025-10-15', 'Klausur'),
(1, 2, 1.7, '2025-10-20', 'Klausur'),
(1, 1, 2.0, '2025-11-05', 'mündlich'),
-- Anna Schmidt
(2, 1, 1.3, '2025-10-15', 'Klausur'),
(2, 3, 2.0, '2025-10-18', 'Hausaufgabe'),
(2, 1, 1.7, '2025-11-05', 'mündlich'),
-- Tom Weber
(3, 1, 3.0, '2025-10-15', 'Klausur'),
(3, 2, 2.3, '2025-10-20', 'Klausur'),
-- Lisa Meyer
(4, 1, 1.7, '2025-10-15', 'Klausur'),
(4, 3, 1.3, '2025-10-18', 'Hausaufgabe'),
(4, 4, 2.0, '2025-10-22', 'Klausur'),
-- Paul Fischer
(5, 1, 2.7, '2025-10-15', 'Klausur'),
(5, 5, 2.0, '2025-10-25', 'Klausur'),
-- Sarah Becker
(6, 2, 1.0, '2025-10-20', 'Klausur'),
(6, 5, 1.3, '2025-10-25', 'Klausur'),
-- Leon Schulz
(7, 1, 2.0, '2025-10-15', 'Klausur'),
(7, 2, 1.7, '2025-10-20', 'Klausur'),
-- Emma Wagner
(8, 3, 1.7, '2025-10-18', 'Hausaufgabe'),
(8, 4, 2.3, '2025-10-22', 'Klausur'),
-- Jonas Hoffmann
(9, 2, 2.0, '2025-10-20', 'Klausur'),
(9, 5, 2.7, '2025-10-25', 'Klausur'),
-- Mia Koch
(10, 2, 1.3, '2025-10-20', 'Klausur'),
(10, 5, 1.0, '2025-10-25', 'Klausur');
