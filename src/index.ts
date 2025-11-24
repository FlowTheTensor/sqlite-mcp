#!/usr/bin/env node

import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
  Tool
} from "@modelcontextprotocol/sdk/types.js";
import Database from "better-sqlite3";
import { fileURLToPath } from "url";
import { dirname, join } from "path";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Pfad zur Datenbank (im gleichen Verzeichnis wie das Projekt)
const DB_PATH = join(__dirname, "..", "schule.db");

// Datenbank-Verbindung
const db = new Database(DB_PATH, { readonly: false });

// MCP Server erstellen
const server = new Server(
  {
    name: "sqlite-mcp-server",
    version: "1.0.0",
  },
  {
    capabilities: {
      tools: {},
    },
  }
);

// Tool-Definitionen
const TOOLS: Tool[] = [
  {
    name: "query_database",
    description: "Führt eine SQL SELECT-Abfrage auf der Schul-Datenbank aus. Gibt die Ergebnisse als JSON zurück.",
    inputSchema: {
      type: "object",
      properties: {
        query: {
          type: "string",
          description: "Die SQL SELECT-Abfrage, die ausgeführt werden soll (z.B. 'SELECT * FROM schueler')"
        }
      },
      required: ["query"]
    }
  },
  {
    name: "list_tables",
    description: "Listet alle Tabellen in der Datenbank auf.",
    inputSchema: {
      type: "object",
      properties: {}
    }
  },
  {
    name: "describe_table",
    description: "Zeigt die Struktur einer Tabelle (Spalten und Datentypen).",
    inputSchema: {
      type: "object",
      properties: {
        table_name: {
          type: "string",
          description: "Der Name der Tabelle, die beschrieben werden soll"
        }
      },
      required: ["table_name"]
    }
  }
];

// Handler für list_tools
server.setRequestHandler(ListToolsRequestSchema, async () => {
  return { tools: TOOLS };
});

// Handler für call_tool
server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args } = request.params;

  try {
    if (name === "query_database") {
      const query = args.query as string;
      
      // Sicherheitscheck: Nur SELECT-Abfragen erlauben
      if (!query.trim().toUpperCase().startsWith("SELECT")) {
        return {
          content: [
            {
              type: "text",
              text: "Fehler: Nur SELECT-Abfragen sind erlaubt!"
            }
          ]
        };
      }

      const stmt = db.prepare(query);
      const results = stmt.all();

      return {
        content: [
          {
            type: "text",
            text: JSON.stringify(results, null, 2)
          }
        ]
      };
    }

    if (name === "list_tables") {
      const tables = db.prepare(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'"
      ).all();

      return {
        content: [
          {
            type: "text",
            text: JSON.stringify(tables, null, 2)
          }
        ]
      };
    }

    if (name === "describe_table") {
      const tableName = args.table_name as string;
      const columns = db.prepare(`PRAGMA table_info(${tableName})`).all();

      return {
        content: [
          {
            type: "text",
            text: JSON.stringify(columns, null, 2)
          }
        ]
      };
    }

    return {
      content: [
        {
          type: "text",
          text: `Unbekanntes Tool: ${name}`
        }
      ]
    };
  } catch (error) {
    return {
      content: [
        {
          type: "text",
          text: `Fehler: ${error instanceof Error ? error.message : String(error)}`
        }
      ]
    };
  }
});

// Server starten
async function main() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
  console.error("SQLite MCP Server gestartet");
}

main().catch((error) => {
  console.error("Fehler beim Starten des Servers:", error);
  process.exit(1);
});
