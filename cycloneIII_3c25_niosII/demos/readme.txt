==================================================
ABOUT THE DEMOS DIRECTORY
==================================================

What is in the demos directory? 
------------------------------- 
The "demos" directory is a repository of pre-built example designs that 
may be useful for you to evaluate or run.  Many of these may be Nios II based
processor systems that have been provided for demonstration and evaluation 
purposes only. In this directory you will find information about Ready to Run
demos and demonstration design examples.   


How are the demos different from design examples?
-------------------------------------------------
Design examples (located in the <Install Dir>\examples directory of your kit
installation) are pre-built hardware systems that can be used as a starting 
point for your own design.
1) Hardware Design Examples: Quartus II projects with pre-generated hardware
   images (often using the SOPC Builder system-building tool and featuring 
   the Nios II processor).
2) System Design Examples:  These build upon hardware design examples and 
   include applications and source codes that show examples of software device 
   drivers, operating system usage etc. (e.g. application selector)

Demonstrations on the other hand, are for evaluation purposes only are not 
guaranteed to be updated with each release of the Quartus II software. To that 
end, when source-code is provided, re-compiling a demonstration application 
from this directory may or may not work with the Quartus II version that was 
pointed to by the development kit documentation.  Any source-code provided 
should be viewed as diagramatic but not necessarily functional.  


==================================================
ABOUT THE Ready to Run Demos
==================================================

What are Ready to Run Demos?
----------------------------
Ready to Run demos are binary (flash) files of processor systems that can be
programmed to flash or selected and loaded from the LCD touch panel. Ready to 
Run demos provide a quick and easy way to evaluate Nios II based processor 
systems built for applications such as automotive graphics, industrial controls, 
consumer graphic user interfaces and more. Most Ready to Run demos have been 
provided by Altera's partners and showcase IP, operating systems and software 
tools.
 

Where can I find Ready to Run Demos?
------------------------------------
   1) For the Nios II Embedded Evaluation Kit (NEEK), there are many "Ready to 
      Run" demos available on the SD CARD. 

   2) A menu listing all the demos stored on the SD-Card appears when the NEEK 
      is first powered up. For usage instructions use the LCD Touch Screen to 
      highlight the demo and press the "Info" button.

   3) The "Ready to Run" demos that you see on the display of the Nios II 
      Embedded Evaluation Kit can be found in the kit installation directory 
      at <Install Dir>\factory_recovery\sdcard_contents\Altera_EEK_Applications


What is in a Ready to Run Demo? 
-------------------------------
A Ready-to-Run demo consists of :
   1) Binary image (.flash format) containing the FPGA hardware image
   2) Binary image (.flash format) containing the software application
   3) Optional info.txt file containing a brief description of the demo
   4) Optional data files, jpegs, videos etc. referenced by the demo

 
How do Ready to Run demos get loaded from the SD card to the FPGA?
------------------------------------------------------------------
When you select one of these demos from main menu on the LCD screen, the 
default design called application selector copies these images from the
SD Card to the Flash memory and reconfigures the FPGA with your chosen demo.  

 
Can I get more Ready to Run Demos?
----------------------------------
Yes, in addition to the pre-packaged Ready to Run SD Card Demo applications 
which come with the Nios II Embedded Evaluation Kit, Cyclone III Edition, more 
are available from Altera or through third party vendors.  To get more Ready 
to Run SD Card demo applications visit: 

    www.altera.com/nios2eval.
 

Where can I get full Quartus II projects and source code for Ready to Run Demos?
--------------------------------------------------------------------------------
Altera's partners can provide full Quartus II projects, source code, development
tools and even design services to get you up and running developing products. 
You will find links to partners from www.altera.com/nios2eval


For more detailed information please read the Nios II Embedded Evaluation
Kit (NEEK), Cyclone III Edition Getting Started User Guide in the "documents"
directory of your NEEK installation.

