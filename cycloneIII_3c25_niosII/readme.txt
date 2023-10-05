//+---------------------------------------------------------------------------
//|
//| Nios II Embedded Evaluation Kit (NEEK), Cyclone III Edition
//| Readme v12.1.0
//|
//+---------------------------------------------------------------------------

This readme.txt file accompanies the Nios II Embedded Evaluation Kit (NEEK), Cyclone III Edition

Revision History
===================
	Version 12.1.0: Update for Quartus II 12.1.0.
	
	Version 12.0.0: Update for Quartus II 12.0.0.
	
    Version 11.0.0: Update for Quartus II 11.0.0. Updated Application Selector
		    from SOPC design based to QSYS design based.
			
    Version 10.1.0: Update for Quartus II 10.1.0.
	
    Version  9.1.2: Update for Quartus II 9.1.2. Updated Application Selector
		    and example designs. Updated webserver_html to new interface
 
    Version  8.0.0: Updated Q3 2008, Updated Application Selector and example
		    designs.  Webserver integrated into Application Selector.
		    Documentation updates and bug-fixes.

    Version  7.2.0: Initial release

//=============================
//    System Requirements
//=============================

Software Requirements
========================
Demo appliations require the installation of Quartus II v11.1.0 or later and are
supported on the following operating systems:
   Windows XP SP3 32-bit 
   Windows XP SP2 64-bit
   Windows 7 Professional 64-bit


Hardware Requirements
========================
   Pentium III or later for Windows
   Color display capable of 1024 X 768 pixel resolution
   CD-ROM drive
   One or more of the following I/O ports:
   -  USB port (if using Windows XP or Windows 2000) for 
      USB-Blaster(TM) or MasterBlaster(TM) 
      communications cables, or APU programming unit
   -  Ethernet port with DHCP (for Board Update Portal)

//=============================
//       Release Notes
//=============================

(1) Updated cycloneiii_3c25_niosii_standard from SOPC based to QSYS based design.

(2) When generating application_boot_code.srec file by running "make" command in 
    app_selector_boot_code folder using Nios II 11.0 Command Shell [gcc4], "app_selector_boot_code.hex" 
    is not created.

(3) Nios II EDS 11.1 doesn't support mandelbrot.elf file generation using create-this-app script in demos/
    c2h_mandelbrot/software_examples/app/mandelbrot_c2h folder. Go to demos/c2h_mandelbrot/binary folder
    to get the pre-generated mandelbrot.elf file.  

(4) RS-232 UART IO Control - must manually edit system.h
    If your hardware design includes a RS-232 UART and sets I/O Control support
    on, then you may find that compiled software does not work.

    Reason: The driver ioctl() support for altera_avalon_uart component contains
    an invalid type for uart parameter, which causes uart driver fail to 
    evaluate the parameter value.
 
    Resolution: 
      a. Manually edit system.h file:
         change: #define UART1_PARITY "N"
         to: #define UART1_PARITY 'N'
         (i.e. change double-quote character to single-quote character)
      b. Re-build bsp package

(5) If recompiling the Altera provided Nios II Embedded Evaluation Kit 
    designs, you will get a critical warning for non-compensated plls.  This is 
    due to PIN_V9 being dedicated to only 1 PLL. Another PLL that is connected 
    to the same PIN will be designated as "link/route" connection by using a 
    "remote clock" via the second clock control block.  The example designs 
    have been tested and shown to work even though this clocking structure is
    sub-optimal.  
	
(6) Mandelbrot_c2h - must remove the following files in app folder before re-generate 
    the application. 
    alt_c2h_hw_draw_int_mandelbrot.c
    alt_c2h_hw_draw_int_mandelbrot_irq.h
    Makefile

    The expected flow for a new user would be:
------------------------------------------------------------------------------
1. Quick Start Guide (Printed and in the box)
   This includes directions for downloading and installing the software,
   installing the Nios II Embedded Evaluation Kit installer and doing a power-on
   test with the Development Board.

2. User Guide
   In addition to more detailed instructions about installing the software,
   this document has information about running the applications selector and
   the sample applications that are stored on the SD-Card.

3. My First Nios II Software Tutorial
   This document describes using the Nios II Processor in an FPGA.  It walks
   you through compiling and running software on a provided Nios II Standard
   system.

4. My First FPGA Tutorial
   This document walks you through creating your first Quaruts II project
   and building an FPGA design that can be downloaded and run on the 
   cyclone III Starter Board.  This assumes you have downloaded and installed
   the Quartus II software and installed the USB Blaster Driver.  With these
   installed, the My First FPGA Tutorial should take about an hour from start
   to finish.

From this point there are many more things you can do with your Nios II 
Embedded Evaluation Kit, Cyclone III Edition.  Check the Altera website for 
updates for this development kit.
                

Contacting Altera
=================
If you have additional questions, contact Altera Applications using one of 
the following methods:

Technical Support Hotline 	(800) 800-EPLD (U.S.)
                                (408) 544-7000 (Internationally)
Online Technical Support        http://www.altera.com/mysupport
World-Wide Web 	                http://www.altera.com

Copyright (c) 2011 Altera Corporation. All rights reserved.
