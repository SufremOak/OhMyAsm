import { runCommand } from "@vef/easy-command";
import { Command } from "npm:commander";

const program = new Command();

function runAsm(file: string) {
    //
}

program
    .name('lasm')
    .description('The OhMyAsm Compiler')

program.command('run <file.asm>')
        .description('Run an LASM file')
        .action(function() {
            // logic to run a LASM file
        });