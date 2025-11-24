# Anleitung für Schüler: SQLite MCP Server

## Schnellstart-Anleitung

### 1. Installation vorbereiten
Öffne PowerShell im Projektordner und führe aus:

```powershell
npm install
```

Das installiert alle benötigten Pakete.

### 2. Datenbank erstellen
```powershell
node create_database.js
```

Du solltest die Meldung sehen: "Datenbank erfolgreich erstellt und befüllt!"

### 3. Server kompilieren
```powershell
npm run build
```

### 4. In Claude Desktop einbinden

**Konfigurationsdatei öffnen:**
- Drücke `Windows + R`
- Gib ein: `%APPDATA%\Claude`
- Öffne die Datei `claude_desktop_config.json` mit einem Texteditor

**Server hinzufügen:**
Füge folgendes ein (passe den Pfad an!):

```json
{
  "mcpServers": {
    "sqlite-schule": {
      "command": "node",
      "args": [
        "DEIN_PFAD_HIER\\build\\index.js"
      ]
    }
  }
}
```

**Pfad herausfinden:**
Im Projektordner in PowerShell:
```powershell
Get-Location
```

Kopiere den Pfad und füge `\build\index.js` hinzu.

### 5. Claude Desktop neu starten

Schließe Claude Desktop komplett und starte es neu.

### 6. Testen

Stelle Claude eine Frage wie:
```
Welche Schüler gibt es in der Datenbank?
```

Claude sollte jetzt die Datenbank abfragen können!

## Beispiel-Fragen zum Ausprobieren

### Einfach:
- "Zeige alle Schüler"
- "Welche Lehrer gibt es?"
- "Liste alle Kurse auf"

### Mittel:
- "Zeige alle Schüler aus Klasse 10a"
- "Welche Noten hat Max Mustermann?"
- "Wer unterrichtet Informatik?"

### Fortgeschritten:
- "Berechne den Notendurchschnitt von Anna Schmidt"
- "Welche Schüler haben in Mathematik eine 1 vor dem Komma?"
- "Zeige alle Klausurnoten mit Schülernamen und Kursnamen"

## Datenbank-Struktur verstehen

Die Datenbank hat 4 Tabellen:

📚 **schueler**: Schülerinformationen
- id, vorname, nachname, klasse, geburtsdatum, email

👨‍🏫 **lehrer**: Lehrerinformationen  
- id, vorname, nachname, fach, raum

📖 **kurse**: Kursinformationen
- id, kursname, lehrer_id, raum, wochentag, uhrzeit

📝 **noten**: Noten
- id, schueler_id, kurs_id, note, datum, art

## Häufige Probleme

**Claude antwortet, aber ohne Datenbankzugriff?**
→ Server wurde nicht richtig konfiguriert oder Claude nicht neu gestartet

**"Cannot find module" Fehler?**
→ `npm install` ausführen

**Datenbank leer?**
→ `node create_database.js` ausführen

## Was passiert im Hintergrund?

1. Du stellst Claude eine Frage
2. Claude erkennt, dass es Datenbankinfos braucht
3. Claude ruft eines der Tools auf:
   - `list_tables` - Welche Tabellen gibt es?
   - `describe_table` - Wie sieht eine Tabelle aus?
   - `query_database` - SQL-Abfrage ausführen
4. Der MCP-Server führt die Abfrage aus
5. Claude bekommt das Ergebnis und antwortet dir

## Aufgaben zum Experimentieren

1. Stelle 5 verschiedene Fragen an die Datenbank
2. Lass dir die Struktur aller Tabellen zeigen
3. Frage nach dem besten Schüler in einem Fach
4. Lass Claude eine komplexe Abfrage mit mehreren Tabellen erstellen
5. Experimentiere mit Aggregationen (Durchschnitt, Anzahl, etc.)

Viel Erfolg! 🚀
