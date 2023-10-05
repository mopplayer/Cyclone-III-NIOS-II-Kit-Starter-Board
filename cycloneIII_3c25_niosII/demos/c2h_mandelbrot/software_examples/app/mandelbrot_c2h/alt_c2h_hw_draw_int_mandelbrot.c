/* Legal Notice: (C)2012 Altera Corporation. All rights reserved.  Your */
/* use of Altera Corporation's design tools, logic functions and other */
/* software and tools, and its AMPP partner logic functions, and any */
/* output files any of the foregoing (including device programming or */
/* simulation files), and any associated documentation or information are */
/* expressly subject to the terms and conditions of the Altera Program */
/* License Subscription Agreement or other applicable license agreement, */
/* including, without limitation, that your use is for the sole purpose */
/* of programming logic devices manufactured by Altera and sold by Altera */
/* or its authorized distributors.  Please refer to the applicable */
/* agreement for further details. */

#ifdef CHAC_THIS
#else
#include "io.h"
#include "c2h_accelerator_base_addresses.h"

__inline__ void hw_draw_int_mandelbrot ( long long current_x,
                                long long current_y,
                                long long step_dim,
                                int max_iter,
                               unsigned long *  __restrict__  frame_buffer
                             )
{
  IOWR_32DIRECT(ACCELERATOR_MANDELBROT_HW_DRAW_INT_MANDELBROT_MANAGED_INSTANCE_CPU_INTERFACE0_BASE, (4), (int) (current_x));
  IOWR_32DIRECT(ACCELERATOR_MANDELBROT_HW_DRAW_INT_MANDELBROT_MANAGED_INSTANCE_CPU_INTERFACE0_BASE, (8), (int) (current_x >> 32));
  IOWR_32DIRECT(ACCELERATOR_MANDELBROT_HW_DRAW_INT_MANDELBROT_MANAGED_INSTANCE_CPU_INTERFACE0_BASE, (12), (int) (current_y));
  IOWR_32DIRECT(ACCELERATOR_MANDELBROT_HW_DRAW_INT_MANDELBROT_MANAGED_INSTANCE_CPU_INTERFACE0_BASE, (16), (int) (current_y >> 32));
  IOWR_32DIRECT(ACCELERATOR_MANDELBROT_HW_DRAW_INT_MANDELBROT_MANAGED_INSTANCE_CPU_INTERFACE0_BASE, (20), (int) (step_dim));
  IOWR_32DIRECT(ACCELERATOR_MANDELBROT_HW_DRAW_INT_MANDELBROT_MANAGED_INSTANCE_CPU_INTERFACE0_BASE, (24), (int) (step_dim >> 32));
  IOWR_32DIRECT(ACCELERATOR_MANDELBROT_HW_DRAW_INT_MANDELBROT_MANAGED_INSTANCE_CPU_INTERFACE0_BASE, (28), (int) (max_iter));
  IOWR_32DIRECT(ACCELERATOR_MANDELBROT_HW_DRAW_INT_MANDELBROT_MANAGED_INSTANCE_CPU_INTERFACE0_BASE, (32), (int) (frame_buffer));
  /* Write 1 to address 0 starts the accelerator */
  IOWR_32DIRECT(ACCELERATOR_MANDELBROT_HW_DRAW_INT_MANDELBROT_MANAGED_INSTANCE_CPU_INTERFACE0_BASE,(0 * sizeof(int)),1);
  
  /* C2H Register Behavior with IRQ: */
  /* Any write operation clears the interrupt. */
  /* A write to (accelerator base + 0) starts the accelerator, if the lsb is 1. */
  /* The safest way to clear the IRQ without starting the accelerator is to write 0 to (accelerator base + 0) */
  
  /* HW IRQ is enabled, so the polling loop was removed. */
  /* #define POLL_ACCELERATOR_MANDELBROT_HW_DRAW_INT_MANDELBROT_MANAGED_INSTANCE to re-enable polling loop. */
#ifdef POLL_ACCELERATOR_MANDELBROT_HW_DRAW_INT_MANDELBROT_MANAGED_INSTANCE
  while(IORD_32DIRECT(ACCELERATOR_MANDELBROT_HW_DRAW_INT_MANDELBROT_MANAGED_INSTANCE_CPU_INTERFACE0_BASE,(0 * sizeof(int))) == 0) {}
  
#endif
}
#endif /* CHAC_THIS */




