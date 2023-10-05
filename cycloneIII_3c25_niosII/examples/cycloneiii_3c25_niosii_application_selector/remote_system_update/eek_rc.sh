#!/bin/sh


  # Check the number of arguments passed into the script
  #
  if [ $# -ne 2 ] ; then
    echo ""
    echo "ERROR: There must be two arguments passed to this script."
    echo ""
    echo "USAGE: ./eek.sh <app_name.elf> <fpga_conf.sof>"
    echo "       <app_name.elf>      = ELF file containing application code"
    echo "       <fpga_conf.sof>     = SOF file containing FPGA image"
    echo ""
    exit 1;
  fi

  # Check that the input files actually exists before we proceed  
  #
  for argument in "$1" "$2"
  do
    if [ ! -e $argument ] ; then
      echo ""
      echo "ERROR: Cannot find file $argument."
      echo ""
      exit 1;
    fi
  done

# Grab the base names of the .elf and sof files.
elfbase=$(echo $1 | sed 's/\.elf//')
sofbase=$(echo $2 | sed 's/\.sof//')

# Perform the file conversions
elf2flash --base=0x04000000 --end=0x4FFFFFF --reset=0x4240000 --input=$1 --output=$elfbase\_sw.flash --boot=$SOPC_KIT_NIOS2/components/altera_nios2/boot_loader_cfi.srec
sof2flash --activeparallel --timestamp --input=$2 --output=$sofbase\_hw.flash --offset=0xe00000
