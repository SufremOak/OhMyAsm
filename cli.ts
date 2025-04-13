import { Command } from 'commander';
import chalk from 'chalk';
import fs from 'fs';
import path from 'path';
import peg from './src/lasm.ts';

const program = new Command();

program
  .name('lasm')
  .description('An assembler-like application')
  .version('0.1.0');

program
  .command('assemble')
  .description('Assemble an assembly file')
  .argument('<file-path>', 'Path to the assembly file (.asm or .s)')
  .action((filePath) => {
    try {
      const absolutePath = path.resolve(filePath);
      const fileContent = fs.readFileSync(absolutePath, 'utf-8');
      const ast = peg.parse(fileContent);
      console.log(JSON.stringify(ast, null, 2));
      
      // Example of processing the AST, if needed
      
      // Function to process the AST.
        function processAST(node: any): void {
            if (Array.isArray(node)) {
              node.forEach(processAST);
              return;
            }

            if (typeof node !== 'object' || node === null) {
                return;
            }
            
          switch (node.type) {
            case 'instruction':
              console.log(chalk.green(`Instruction: ${node.name}`));
              if (node.operands) {
                node.operands.forEach((operand: any) => {
                  processAST(operand);
                });
              }
              break;
            case 'label':
              console.log(chalk.blue(`Label: ${node.name}`));
              break;
            case 'variable':
              console.log(chalk.yellow(`Variable: ${node.name}, Type: ${node.dataType}`));
              break;
            case 'constant':
              console.log(chalk.magenta(`Constant: ${node.name}, Value: ${node.value}, Type: ${node.dataType}`));
              break;
            case 'register':
              console.log(chalk.cyan(`Register: ${node.name}`));
              break;
            case 'memory':
              console.log(chalk.gray(`Memory: `));
              processAST(node.address);
              break;
            case 'immediate':
              console.log(chalk.red(`Immediate: ${node.value}, Type: ${node.dataType}`));
              break;
            case 'string':
                console.log(chalk.green(`String: ${node.value}`));
                break;
            case 'identifier':
                console.log(chalk.white(`Identifier: ${node.name}`));
                break;
            case 'binary_expression':
                console.log(chalk.white(`Binary Expression: `));
                processAST(node.left);
                console.log(chalk.white(`Operator: ${node.operator}`));
                processAST(node.right);
                break;
            default:
              console.log(chalk.white(`Unknown Node: ${JSON.stringify(node)}`));
          }
        }
      processAST(ast);
      
    } catch (error) {
      if (error instanceof Error) {
        console.error(chalk.red(`Error: ${error.message}`));
      } else {
        console.error(chalk.red(`An unknown error occurred: ${error}`));
      }
    }
  });

program.parse(process.argv);
