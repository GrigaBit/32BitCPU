# 32Bit CPU
This is my first attempt at developing a 32-bit CPU architecture.
In the following lines, I will detail some of the essential aspects taken into account during development.

1)Processor architecture
The processor architecture is based on RISC V with some features borrowed from the architectures used in ARM processors. 
The main components of the processor are: 

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

![tabel_simplu](https://github.com/user-attachments/assets/72648836-e0f6-4fef-9754-2381aec20d2a)

S - is the bit that indicates whether the instruction sets the Flags or not
Rn/Rd - the first register and the destination register respectively

