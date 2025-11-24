# SQLite MCP Server Projekt

Ein Projekt zum Lernen, wie man eine SQLite-Datenbank mit einem LLM über einen MCP-Server abfragt.

## Was ist MCP?

Das **Model Context Protocol (MCP)** ist ein offener Standard, der es Large Language Models (LLMs) ermöglicht, mit externen Datenquellen und Tools zu kommunizieren. In diesem Projekt nutzen wir MCP, um einem LLM Zugriff auf eine SQLite-Datenbank zu geben.

## Projektstruktur

```
sqlite-mcp/
├── src/
│   └── index.ts          # Der MCP-Server Code
├── package.json          # Node.js Abhängigkeiten
├── tsconfig.json         # TypeScript Konfiguration
├── init_database.sql     # SQL-Script zum Erstellen der Datenbank
├── create_database.js    # Script zum Initialisieren der Datenbank
└── schule.db            # Die SQLite-Datenbank (wird erstellt)
```

## Die Beispiel-Datenbank

Die Datenbank `schule.db` enthält vier Tabellen:

### 1. **schueler**
- Enthält Informationen über Schüler (Name, Klasse, Geburtsdatum, Email)
- 10 Beispiel-Schüler aus verschiedenen Klassen

### 2. **lehrer**
- Informationen über Lehrer (Name, Fach, Raum)
- 5 Lehrer mit verschiedenen Fächern

### 3. **kurse**
- Kursinformationen (Name, Lehrer, Raum, Zeitplan)
- 5 verschiedene Kurse

### 4. **noten**
- Noten von Schülern in verschiedenen Kursen
- Verschiedene Arten: Klausuren, mündliche Noten, Hausaufgaben

## Installation

### Voraussetzungen
- Node.js (Version 18 oder höher)
- npm (wird mit Node.js installiert)

### Schritt 1: Abhängigkeiten installieren

```powershell
npm install
```

### Schritt 2: Datenbank erstellen

```powershell
node create_database.js
```

Dies erstellt die Datei `schule.db` mit allen Tabellen und Beispieldaten.

### Schritt 3: Server kompilieren

```powershell
npm run build
```

Dies kompiliert den TypeScript-Code in das `build/` Verzeichnis.

## Verwendung mit Claude Desktop

### MCP-Server konfigurieren

1. Öffne die Claude Desktop Konfigurationsdatei:
   - Windows: `%APPDATA%\Claude\claude_desktop_config.json`

2. Füge den MCP-Server hinzu:

```json
{
  "mcpServers": {
    "sqlite-schule": {
      "command": "node",
      "args": [
        "C:\\Users\\TABLEERER\\OneDrive - Jakob-Preh-Schule\\Fortbildungen\\Fachgruppe KI\\2025-11-24 AÖ\\SQLite per MCP\\build\\index.js"
      ]
    }
  }
}
```

**Wichtig:** Passe den Pfad in `args` an deinen tatsächlichen Projektpfad an!

3. Starte Claude Desktop neu

### Den MCP-Server nutzen

Jetzt kannst du Claude in natürlicher Sprache Fragen zur Datenbank stellen, z.B.:

- "Zeige mir alle Schüler aus der Klasse 10a"
- "Welche Kurse gibt es und wer unterrichtet sie?"
- "Was ist der Notendurchschnitt von Max Mustermann?"
- "Liste alle Schüler auf, die eine Note besser als 2.0 haben"
- "Welcher Lehrer unterrichtet Informatik?"

Claude wird automatisch die verfügbaren Tools nutzen:
- `list_tables` - Zeigt alle Tabellen
- `describe_table` - Zeigt die Struktur einer Tabelle
- `query_database` - Führt SQL-Abfragen aus

## Verfügbare Tools

### 1. list_tables
Listet alle Tabellen in der Datenbank auf.

**Beispiel:**
```
Welche Tabellen gibt es in der Datenbank?
```

### 2. describe_table
Zeigt die Struktur (Spalten und Datentypen) einer Tabelle.

**Beispiel:**
```
Wie ist die Tabelle 'schueler' aufgebaut?
```

### 3. query_database
Führt eine SQL SELECT-Abfrage aus.

**Beispiel:**
```
Zeige alle Schüler mit ihren Klassen
```

Claude wird automatisch die SQL-Abfrage generieren:
```sql
SELECT vorname, nachname, klasse FROM schueler
```

## Beispiel-Abfragen zum Ausprobieren

1. **Einfache Abfragen:**
   - "Zeige alle Schüler"
   - "Liste alle Lehrer auf"
   - "Welche Kurse gibt es?"

2. **Abfragen mit Bedingungen:**
   - "Zeige alle Schüler aus Klasse 10a"
   - "Welcher Lehrer unterrichtet im Raum B205?"
   - "Zeige alle Noten vom 15. Oktober 2025"

3. **Komplexe Abfragen (mit JOINs):**
   - "Zeige alle Noten mit Schülernamen und Kursnamen"
   - "Welche Schüler sind in welchen Kursen?"
   - "Liste alle Klausurnoten mit Schüler- und Kursinformationen"

4. **Aggregationen:**
   - "Was ist der Notendurchschnitt pro Schüler?"
   - "Wie viele Schüler gibt es pro Klasse?"
   - "Was ist die beste Note in Mathematik?"

## Sicherheit

Der MCP-Server erlaubt aus Sicherheitsgründen **nur SELECT-Abfragen**. Das bedeutet:
- ✅ Daten können gelesen werden
- ❌ Daten können NICHT verändert, gelöscht oder hinzugefügt werden

Dies schützt die Datenbank vor versehentlichen Änderungen.

## Lernziele

Durch dieses Projekt lernst du:
1. Wie MCP-Server funktionieren
2. Wie LLMs mit Datenbanken interagieren können
3. Grundlagen von SQL-Abfragen
4. TypeScript und Node.js Entwicklung
5. Wie man Tools für AI-Assistenten bereitstellt

## Troubleshooting

### "Cannot find module" Fehler
→ Führe `npm install` aus

### "Database not found" Fehler
→ Führe `node create_database.js` aus

### Server startet nicht in Claude
→ Überprüfe den Pfad in der `claude_desktop_config.json`
→ Stelle sicher, dass `npm run build` erfolgreich war

### Permissions-Fehler
→ Stelle sicher, dass du Schreibrechte im Projektordner hast

## Weiterführende Ideen

- Erweitere die Datenbank um weitere Tabellen (z.B. Fächer, Stundenplan)
- Füge mehr Beispieldaten hinzu
- Erstelle komplexere SQL-Abfragen
- Implementiere zusätzliche Tools (z.B. für Statistiken)
- Experimentiere mit verschiedenen Fragestellungen an Claude


