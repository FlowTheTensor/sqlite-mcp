const Database = require('better-sqlite3');
const fs = require('fs');
const path = require('path');

// Datenbank erstellen
const db = new Database('schule.db');

// SQL-Script laden und ausführen
const sqlScript = fs.readFileSync(path.join(__dirname, 'init_database.sql'), 'utf8');

// Script in einzelne Statements aufteilen und ausführen
const statements = sqlScript
  .split(';')
  .map(s => s.trim())
  .filter(s => s.length > 0 && !s.startsWith('--'));

statements.forEach(statement => {
  try {
    db.exec(statement);
  } catch (error) {
    console.error('Fehler beim Ausführen:', statement);
    console.error(error.message);
  }
});

console.log('Datenbank erfolgreich erstellt und befüllt!');
db.close();
