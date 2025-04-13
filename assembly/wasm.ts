import { init, Wasmer, runWasix, initializeLogger } from '@wasmer/sdk';

import markdownRendererUrl from "./OhMyAsmWasmHelperRS/target/wasm32-wasi/release/OhMyAsmWasmHelperRS.wasm?url";

export function WasmerFunc(OhMyAsmWasmHelper: type) {
    function main(): void {
        /**the main function is the main function of the assembly language */
    }
    return void;
}

function main() {
    await init();
  //  const pkg = await Wasmer.fromResgistry("")
    return WebAssembly.compileStreaming(fetch(OhMyAsmWasmHelperRS));
}

/**the OhMyAsmWasmHelper function is the helper function for the assembly language  */
export default function OhMyAsmWasmHelper(name: string, funcName: string, byteType: string): void {
    const u32fn = byteType; /**byteType helper */
}

