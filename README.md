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

![image](https://github.com/user-attachments/assets/5f41a271-d840-4bbf-81bb-fb1017456ac9)


Cond means the condition that must be met, for example for 0000 the condition is "Equal", for 0001 the condition is "Not Equal" .

OP means the type of instruction. Instructions can be: 00 for data processing instructions, 01 for memory instructions and 10 for Branch type instructions.

I is the bit that indicates whether the instruction uses a register or an immediate value as a secondary source .

Cmd shows us the operation that the instruction will execute, in our case one of the 4: ADD, AND, SUB, ORR .

S is the bit that indicates whether the instruction sets the Flags or not Rn/Rd - the first register and the destination register respectively.

Rn/Rd indicates the source register and the destination register respectively.

Src2 indicates the secondary source of the data.

Data processing instruction :

The data processing instructions have the same structure as the standard one. At positions 27:26 there is the code specific to each type of instruction, in this case 00 for data processing instructions. 
Bit 25 has the value 1 if the data in Src2 will be immediate data, and 0 if there is another register in Src2. In both cases Src2 is divided into other subcategories, but for simplicity we have kept only the strictly necessary information.

![image](https://github.com/user-attachments/assets/7182bb01-ed85-4c40-9d04-d613af86cc76)

Memory instruction:

Memory instructions are the most complex, the classic instruction structure transforming into:

![image](https://github.com/user-attachments/assets/7629d40c-ee16-47c0-8ccd-b99c2abc4052)

The positions that I will deal with in this project are:
Position 25, the I bit which, as in the case of data processing instructions, indicates whether the value in Src2 is immediate or not.
Position 22 and 20, the L&B bits which indicate the instruction subtype, for a moment I will focus only on 2: Load and Store (1.0 and 0.0 respectively).

Branch instructions :

Branch instructions have a simple structure:

![image](https://github.com/user-attachments/assets/a1beec95-3b6d-4f06-8c96-1f2402ce7685)

The Imm24 field will contain the address where the jump is desired, in our case the jump is a maximum of 32 MB.

A simplified diagram of the internal structure of the CPU:

<img width="608" alt="CPU" src="https://github.com/user-attachments/assets/766d41ef-6b11-48b6-81b1-ac0df60eb297" />



*The control part of the system will be uploaded in the near future.
