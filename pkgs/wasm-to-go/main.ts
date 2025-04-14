// wasm-to-go.ts
// Tool to run WebAssembly binaries via @wasmer/sdk

import { Wasmer } from "@wasmer/sdk";

export async function runWasm(filePath: string) {
  const wasmBinary = await Deno.readFile(filePath);

  console.log(`Running ${filePath} using @wasmer/sdk`);

  const wasmer = await Wasmer.fromBinary(wasmBinary);
  const instance = await wasmer.instantiate();

  if (
    "_start" in instance.exports &&
    typeof instance.exports._start === "function"
  ) {
    console.log("Calling _start...");
    instance.exports._start();
  } else {
    console.log("No _start function found. Listing exports:");
    console.log(Object.keys(instance.exports));
  }
}

if (import.meta.main) {
  const args = Deno.args;
  const filePath = args[0];

  if (!filePath) {
    console.error("Usage: deno run --allow-read wasm-to-go.ts <file.wasm>");
    Deno.exit(1);
  }

  await runWasm(filePath);
}
