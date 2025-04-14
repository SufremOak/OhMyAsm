#!/usr/bin/env node

import fs from "node:fs";
import path from "node:path";
import { execSync } from "node:child_process";

const argv = process.argv.slice(2);
const file = argv[0];

if (!file) {
  console.error("Usage: omapm <file>");
  process.exit(1);
}

const content = fs.readFileSync(file, "utf8");
const lines = content.split("\n");

let count = 0;
for (const line of lines) {
  if (line.startsWith("asm")) {
    count++;
  }
}

console.log(`Found ${count} asm lines in ${file}`);
