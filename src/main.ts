/** Interface representing a stack of instructions where each key maps to an array of operations */
export interface InstructionStack {
  [key: string]: Array<() => void>;
}

/** Class representing a single assembly instruction with a label and operation */
export class AsmInstruction {
  private label: string;
  private operation: () => void;

  /**
   * Creates an assembly instruction
   * @param label - The label/name of the instruction
   * @param operation - The operation to execute
   */
  constructor(label: string, operation: () => void) {
    this.label = label;
    this.operation = operation;
  }

  /** Executes the instruction's operation */
  execute(): void {
    this.operation();
  }

  /**
   * Gets the instruction's label
   * @returns The instruction label
   */
  getLabel(): string {
    return this.label;
  }
}

/** Class representing an assembly program with basic operations */
export class Asm {
  private instructions: InstructionStack = {};

  /**
   * Move value from source to destination
   * @param dest - Destination to move value to
   * @param src - Source value to move from
   * @returns New move instruction
   */
  mov(dest: any, src: any): AsmInstruction {
    return new AsmInstruction("mov", () => {
      dest = src;
    });
  }

  /**
   * Add source value to destination
   * @param dest - Destination to add to
   * @param src - Source value to add
   * @returns New add instruction
   */
  add(dest: number, src: number): AsmInstruction {
    return new AsmInstruction("add", () => {
      dest += src;
    });
  }

  /**
   * Subtract source value from destination
   * @param dest - Destination to subtract from
   * @param src - Source value to subtract
   * @returns New subtract instruction
   */
  sub(dest: number, src: number): AsmInstruction {
    return new AsmInstruction("sub", () => {
      dest -= src;
    });
  }

  /**
   * Multiply destination by source value
   * @param dest - Destination to multiply
   * @param src - Source value to multiply by
   * @returns New multiply instruction
   */
  mul(dest: number, src: number): AsmInstruction {
    return new AsmInstruction("mul", () => {
      dest *= src;
    });
  }

  /**
   * Divide destination by source value
   * @param dest - Destination to divide
   * @param src - Source value to divide by
   * @returns New divide instruction
   */
  div(dest: number, src: number): AsmInstruction {
    return new AsmInstruction("div", () => {
      dest /= src;
    });
  }

  /**
   * Jump to and execute instructions at specified label
   * @param label - Label to jump to
   * @returns New jump instruction
   */
  jmp(label: string): AsmInstruction {
    return new AsmInstruction("jmp", () => {
      const instruction = this.instructions[label];
      if (instruction) {
        instruction.forEach((op) => op());
      }
    });
  }

  /**
   * Create a new labeled section of operations
   * @param name - Label name
   * @param operations - Operations to associate with the label
   */
  label(name: string, ...operations: Array<() => void>): void {
    this.instructions[name] = operations;
  }
}

/** Class representing an extended assembly implementation */
export class OhMyAsm {
  /**
   * Creates an OhMyAsm instance
   */
  constructor() {
    // ...
  }
}

/** Default assembly instance */
export const asm = new Asm();
