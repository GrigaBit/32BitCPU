# 32BitCPU
My firs attempt to create a 32 bit CPU in Verilog.


This is my first attempt at developing a 32-bit CPU architecture. In the following lines, I will detail some of the essential aspects taken into account during development.

1)Processor architecture The processor architecture is based on RISC V with some features borrowed from the architectures used in ARM processors. The main components of the processor are:

• GPR – the processor has 16 general purpose registers, each with a length of 32 bits

• Instruction Memory – has a size of 32x32

• Data Memory – the same size

• ALU – capable of currently executing only 4 operations: ADD, SUB, AND, OR

• Extender – to bring the bit streams to the standardized size of 32 bits

• Controller – Divided into 2 subcomponents: Decoder and Conditional Logic

• Other peripherals: MUXs and Simple Adder's

2)The instruction set

The processor will support 3 main types of instructions:

• Data processing instructions

• Memory instructions

• Branch instructions

The standard structure of an instruction is as follows. However, each type of instruction has a particular structure.

tabel_simplu .

Cond means the condition that must be met, for example for 0000 the condition is "Equal", for 0001 the condition is "Not Equal" .

OP means the type of instruction. Instructions can be: 00 for data processing instructions, 01 for memory instructions and 10 for Branch type instructions.

I is the bit that indicates whether the instruction uses a register or an immediate value as a secondary source .

Cmd shows us the operation that the instruction will execute, in our case one of the 4: ADD, AND, SUB, ORR .

S is the bit that indicates whether the instruction sets the Flags or not Rn/Rd - the first register and the destination register respectively.

Rn/Rd indicates the source register and the destination register respectively.

Src2 indicates the secondary source of the data.

*The control part of the system will be uploaded in the near future.
