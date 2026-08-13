# Parameterized Montgomery Multiplier RTL

## Overview

This project implements a parameterized iterative Montgomery multiplier
in Verilog HDL for efficient modular multiplication in cryptographic
hardware applications.

The design uses an FSM-controlled RTL architecture with a dedicated
modular arithmetic datapath and supports configurable operand widths.

## Key Features

- Parameterized operand width
- Iterative Montgomery multiplication
- FSM-based control logic
- Modular arithmetic datapath
- Conditional operand addition
- Modular reduction
- Iterative right-shift operations
- Cycle-based operation control
- Synthesizable Verilog RTL

## Architecture

The design consists of three main RTL components:

### 1. Controller FSM

The controller manages the overall multiplication sequence through
four states:

- `IDLE` – waits for a multiplication request
- `LOAD` – initializes the datapath and operands
- `RUN` – enables iterative Montgomery computation
- `DONE` – indicates completion of the operation

### 2. Datapath

The datapath performs the iterative modular arithmetic operations:

- Conditional addition of operand `B`
- Conditional addition of modulus `N`
- Modular reduction
- Right-shift operation
- Iteration counting

The datapath is parameterized by the operand width.

### 3. Top-Level Integration

The top module integrates the controller FSM and datapath and provides
the external interface for operands, control signals, result, and
operation completion.

## RTL Structure

```text
montgomery-multiplier-rtl/
│
├── rtl/
│   ├── top.v
│   ├── datapath.v
│   └── controller_fsm.v
│
├── tb/
│   └── tb_top.v
│
└── README.md
