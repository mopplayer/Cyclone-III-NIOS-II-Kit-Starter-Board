
Instructions for using eek.sh
=====================================

The eek.sh script takes an .elf file and a .sof file as input.  The script
creates a .flash file for each one which is compatible with the Cyclone III 
Embedded Evaluation Kit Application Selector.

Usage:

./eek.sh <elf_file>.elf <sof_file>.sof

Creates the files
  - <elf_file>_sw.flash
  - <sof_file>_hw.flash

