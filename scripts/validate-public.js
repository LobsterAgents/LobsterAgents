#!/usr/bin/env node

const fs = require("fs");
const path = require("path");

const root = path.resolve(__dirname, "..");
const forbidden = [
  new RegExp("/Users/" + "clawd", "g"),
  new RegExp("OPENAI" + "_API" + "_KEY", "g"),
  new RegExp("ANTHROPIC" + "_API" + "_KEY", "g"),
  new RegExp("CLAUDE" + "_API" + "_KEY", "g"),
  /api[_-]?key\s*[:=]\s*["'][A-Za-z0-9._-]{20,}/gi,
  /token\s*[:=]\s*["'][A-Za-z0-9._-]{20,}/gi,
  /password\s*[:=]\s*["'][^"']{8,}/gi,
  /secret\s*[:=]\s*["'][^"']{8,}/gi
];

const allowedExtensions = new Set([".md", ".json", ".js", ".txt", ""]);
const failures = [];

function walk(dir) {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    if (entry.name === ".git" || entry.name === "node_modules") continue;
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      walk(full);
      continue;
    }
    if (!allowedExtensions.has(path.extname(entry.name))) continue;
    const body = fs.readFileSync(full, "utf8");
    for (const pattern of forbidden) {
      pattern.lastIndex = 0;
      if (pattern.test(body)) {
        failures.push(path.relative(root, full) + " matched " + pattern);
      }
    }
  }
}

walk(root);

if (failures.length) {
  console.error("Public validation failed:");
  for (const failure of failures) console.error("- " + failure);
  process.exit(1);
}

console.log("Public validation passed.");
