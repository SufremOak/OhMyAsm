// ASPM - Assembly Package Manager for OhMyAsm
// CLI tool to install, update, remove, search and publish packages via jsr.io

import { parse } from "@std/flags";
import { join } from "@std/path";
import { ensureDir } from "@std/fs";
import { exists } from "@std/fs";

const REGISTRY = "https://jsr.io";
const MODULES_DIR = "aspm_modules";
const REGISTRY_FILE = "registry.json";

interface MetaData {
  name: string;
  type: string;
  entry: string;
  description: string;
}

async function install(pkg: string) {
  const [user, name] = pkg.replace("@", "").split("/");
  const url = `${REGISTRY}/${user}/${name}`;

  console.log(`Installing ${pkg} from ${url}`);
  const modUrl = `${url}/mod.ts`;
  const metaUrl = `${url}/ohmyasm.meta`;

  const dir = join(MODULES_DIR, name);
  await ensureDir(dir);

  const metaResp = await fetch(metaUrl);
  if (!metaResp.ok) {
    console.error("Failed to fetch metadata.");
    return;
  }
  const meta: MetaData = await metaResp.json();
  await Deno.writeTextFile(
    join(dir, "ohmyasm.meta"),
    JSON.stringify(meta, null, 2),
  );
  await Deno.writeTextFile(join(dir, "mod.ts"), `export * from "${modUrl}";`);

  console.log(`Installed ${pkg} to ${dir}`);
}

async function update(pkg: string) {
  console.log(`Updating ${pkg}...`);
  await install(pkg);
}

async function remove(pkg: string) {
  const [, name] = pkg.replace("@", "").split("/");
  const dir = join(MODULES_DIR, name);
  await Deno.remove(dir, { recursive: true });
  console.log(`Removed ${pkg}`);
}

async function search(query: string) {
  console.log(`Searching for '${query}' on jsr.io...`);
  console.log(
    `Visit https://jsr.io?q=${encodeURIComponent(query)} for full results.`,
  );
}

async function publish() {
  console.log("To publish your package, use the following Deno command:");
  console.log("  deno publish");
}

async function listInstalled() {
  for await (const entry of Deno.readDir(MODULES_DIR)) {
    if (entry.isDirectory) {
      console.log(`- ${entry.name}`);
    }
  }
}

async function main() {
  const args = parse(Deno.args);
  const command = args._[0];
  const target = args._[1] as string;

  switch (command) {
    case "install":
      if (target) await install(target);
      else console.log("Usage: aspm install @user/package");
      break;
    case "update":
      if (target) await update(target);
      else console.log("Usage: aspm update @user/package");
      break;
    case "remove":
      if (target) await remove(target);
      else console.log("Usage: aspm remove @user/package");
      break;
    case "search":
      if (target) await search(target);
      else console.log("Usage: aspm search query");
      break;
    case "publish":
      await publish();
      break;
    case "list":
      await listInstalled();
      break;
    default:
      console.log("ASPM - Assembly Package Manager for OhMyAsm");
      console.log("Usage:");
      console.log("  aspm install @user/package");
      console.log("  aspm update @user/package");
      console.log("  aspm remove @user/package");
      console.log("  aspm search query");
      console.log("  aspm publish");
      console.log("  aspm list");
  }
}

await main();
