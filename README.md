# COS284 Project: Deterministic Finite Automata

[![Run Make](https://github.com/Donatello-Carboni/COS284-Project/actions/workflows/makeBinary.yml/badge.svg)](https://github.com/Donatello-Carboni/COS284-Project/actions/workflows/makeBinary.yml)
[![Clang Format Checker (Linting)](https://github.com/Donatello-Carboni/COS284-Project/actions/workflows/superLinter.yml/badge.svg)](https://github.com/Donatello-Carboni/COS284-Project/actions/workflows/superLinter.yml)

This project is an assignment for the COS284 course at the University of Pretoria. The aim of the project is to design a program for constructing, simulating, and comparing deterministic finite automata (DFA) in assembly language.

## Project Description

The project consists of three deliverables:

- Deliverable 1: Constructing DFA from a file specification.
- Deliverable 2: Simulating input strings over DFA and checking if they are accepted or rejected.
- Deliverable 3: Determining if two DFA represent the same language.

## Project Files

The following files were provided:

- `initDfa.asm`: A helper function for initializing a DFA structure.
- `dfa.h`: A header file with the definitions of the DFA structures and the interfaces for the functions you need to implement.
- `makefile`: A makefile for compiling and linking your ASM files.

## Mark Distribution

The mark distribution for the project is as follows:
| Task | Marks |
| -------------------------- | ----- |
| Constructing DFAs | 30 |
| Verifying Input Strings | 30 |
| Determining Language Equivalence | 40 |
| **Total** | **100** |
