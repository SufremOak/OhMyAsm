markdown
# OhMyAsm

OhMyAsm is a TypeScript and WebAssembly-based Assembly language framework and custom variation.

## Features

-   **TypeScript Support**: Write Assembly code using TypeScript.
-   **WebAssembly Target**: Compile to WebAssembly for high performance.
-   **Custom Assembly**: Define and implement your own Assembly variations.
-   **Cross-Platform**: Run your Assembly code in any environment that supports WebAssembly.
- **Easy to use**: It is simple to implement and get started with the framework.
- **Versatile**: You can easily adapt the framework to work with a wide variety of use cases.

## Getting Started

1.  **Installation**
    
    ```bash
    npx jsr add @sufremoak/ohmyasm 
    ```
    
2. **Example**
    
    ```typescript
        import { OhMyAsmWasmHelper, Asm } from "@sufremoak/ohmyasm";
    
    await Asm.init(this);
    
    $(function() {
        OhMyAsmWasmHelper.AsmCode(__asm__ => {
            __asm__.include("oma.asm");
    
            __asm__.label("_start");
            __asm__.instruction("mov rax, 60");
            __asm__.instruction("mov rdi, 0");
            __asm__.instruction("syscall");
            __asm__.end(code => {
                console.log("Generated Assembly Code:\n", code);
            });
        });
    });
    ```

## Contributing

I welcome contributions to OhMyAsm! Please see our contributing guide for details.

## License

This project is licensed under the MIT License.
