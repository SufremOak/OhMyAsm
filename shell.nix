{ pkgs ? import <nixpkgs> {} }:

with pkgs;
mkShell {
  buildInputs = [
    # Basic Unix tools
    coreutils
    findutils
    gnumake
    gnused
    gnutar
    gzip
    # Additional tools
    git
    curl
    wget
    # nodejs tools
    nodejs
    deno
    yarn
    # WebAssembly tools
    wasm3
    wasmer
    wasmtime
    wasm-pack
    rustup
    docker
  ];

  shellHook = ''
    rustup default stable
    deno install
    echo "Entered development shell"
  '';
}
