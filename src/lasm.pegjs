{
  // Helper functions to create AST nodes.  These make the output of the parser
  // easier to work with in later stages of your assembler.
  function makeInstruction(name, operands) {
    return { type: "instruction", name: name.toLowerCase(), operands: operands };
  }

  function makeLabel(name) {
    return { type: "label", name: name };
  }

  function makeVariable(name, type) {
    return { type: "variable", name: name, dataType: type };
  }

  function makeConstant(name, value, type) {
    return { type: "constant", name: name, value: value, dataType: type };
  }

  function makeRegister(name) {
    return { type: "register", name: name.toLowerCase() };
  }

  function makeMemory(address) {
    return { type: "memory", address: address };
  }

  function makeImmediate(value, type) {
    return { type: "immediate", value: value, dataType: type };
  }

    function makeString(value) {
        return { type: "string", value: value };
    }
}

// The main rule: a LASM program is a sequence of lines.
lasm = program

program = (line _)*

// A line can be one of several things: a label, an instruction, a variable/constant
// declaration, a comment, or just whitespace.
line =
  _ labelDefinition
  / _ instruction
  / _ variableDeclaration
  / _ constantDeclaration
  / _ comment
  / _ // Empty line

// Comments start with a semicolon and go to the end of the line.  They're ignored
// by the assembler (except for documentation, of course!).
comment = ";" [^\n]*

// Labels are used to mark a specific location in the code.  This is essential
// for jumps and branches.
labelDefinition = name ":" { return makeLabel(text()); }

// Variable declarations allocate memory for data.  The type is important!
variableDeclaration =
  "var" _ name ":" _ type { return makeVariable(name, type.toLowerCase()); }

// Constant declarations define values that don't change during program execution.
constantDeclaration =
  "const" _ name ":" _ type _ "=" _ expression { return makeConstant(name, expression.value, expression.dataType); }

// Instructions are the core of the assembly language.  They tell the CPU what to do.
instruction =
  name:mnemonic _ operands:operandList? { return makeInstruction(name, operands ? operands : []); }

// The mnemonic is the name of the instruction (e.g., ADD, MOV, JMP).
mnemonic = [a-zA-Z]+

// An operand list is a comma-separated list of operands.  Some instructions have
// no operands, some have one, and some have several.
operandList = operand ("," _ operand)*

// Operands can be registers, memory locations, immediate values, or names
// (which might be labels or variables).
operand =
  register
  / memory
  / expression
  / name:IDENTIFIER { return { type: "identifier", name: name }; } // For labels/vars

// Registers are special memory locations within the CPU.  They're very fast to
// access.  In this LASM, they start with a '%'.
register = "%" name:REGISTER_NAME { return makeRegister(name); }
REGISTER_NAME = [a-zA-Z0-9]+

// Memory operands refer to locations in the computer's main memory.
memory = "[" _ address:expression _ "]" { return makeMemory(address); }

// Expressions can be more complex, but for now, we'll keep it simple.  This
// handles things like simple arithmetic.  We use a helper rule, 'term',
// to handle operator precedence.
expression = term (("+" / "-") _ term)* {
    let result = value[0];
    for (let i = 1; i < value.length; i += 2) {
      const operator = value[i];
      const right = value[i + 1];
      if (operator === "+") {
        result = {
          type: "binary_expression",
          operator: "+",
          left: result,
          right: right,
          dataType: result.dataType === 'string' || right.dataType === 'string' ? 'string' : 'int' //Basic type inference
        };
      } else {
        result = {
          type: "binary_expression",
          operator: "-",
          left: result,
          right: right,
          dataType: 'int'
        };
      }
    }
    return result;
  }

term = factor (("*" / "/") _ factor)* {
    let result = value[0];
    for (let i = 1; i < value.length; i += 2) {
      const operator = value[i];
      const right = value[i + 1];
      if (operator === "*") {
        result = {
          type: "binary_expression",
          operator: "*",
          left: result,
          right: right,
          dataType: result.dataType === 'string' || right.dataType === 'string' ? 'string' : 'int' //Basic type inference
        };
      } else {
        result = {
          type: "binary_expression",
          operator: "/",
          left: result,
          right: right,
          dataType: 'int'
        };
      }
    }
    return result;
  }

factor =
    immediateWithType
    / string
    / register
    / memory
    / "(" _ expression _ ")" { return value[2]; }
    / name:IDENTIFIER { return { type: "identifier", name: name }; }

// Immediates are constant values embedded directly in the instruction.  They
// can have a type associated with them (e.g., 10:int, 0xFF:byte).
immediateWithType =
  value:immediate _ ":" _ type:type { return makeImmediate(value, type.toLowerCase()); }

// Different ways of writing immediate values.
immediate =
  "-"? [0-9]+ { return {value: parseInt(text(), 10), dataType: 'int'}; }
  / "0x" [0-9a-fA-F]+ { return {value: parseInt(text().substring(2), 16), dataType: 'int'}; }
  / "0b" [01]+ { return {value: parseInt(text().substring(2), 2), dataType: 'int'}; }

string =
  '"' characters:[^"]* '"' { return makeString(characters.join("")); }

// Types define the kind of data being stored (e.g., integer, byte, word).
type = [a-zA-Z0-9]+

// Names (for labels, variables, constants) must follow these rules.
name = IDENTIFIER
IDENTIFIER = [a-zA-Z_][a-zA-Z0-9_]*

// Whitespace is ignored, except when it's needed to separate tokens.
_ "whitespace" = [ \t\r\n]*
