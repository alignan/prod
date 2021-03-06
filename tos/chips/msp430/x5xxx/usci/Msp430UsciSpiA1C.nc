/* DO NOT MODIFY
 * This file cloned from Msp430UsciSpiB0C.nc for A1 */
/*
 * Copyright (c) 2011 João Gonçalves
 * Copyright (c) 2009-2010 People Power Co.
 * All rights reserved.
 *
 * This open source code was developed with funding from People Power Company
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 *
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 *
 * - Neither the name of the copyright holders nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include "msp430usci.h"

/**
 * Generic configuration for a client that shares USCI_A1 in SPI mode.
 *
 * Connected the SPI pins to HplMsp430GeneralIOC
 * @author João Gonçalves <joao.m.goncalves@ist.utl.pt>
 */

generic configuration Msp430UsciSpiA1C() {
  provides {
    interface Resource;
    interface SpiPacket;
    interface SpiByte;
    interface Msp430UsciError;
  }
}
implementation {
  enum {
    CLIENT_ID = unique(MSP430_USCI_A1_RESOURCE),
  };

  components Msp430UsciA1P as UsciC;
  Resource = UsciC.Resource[CLIENT_ID];

  components Msp430UsciSpiA1P as SpiC;
  SpiPacket = SpiC.SpiPacket[CLIENT_ID];
  SpiByte = SpiC.SpiByte;
  Msp430UsciError = SpiC.Msp430UsciError;

  UsciC.ResourceConfigure[CLIENT_ID] -> SpiC.ResourceConfigure[CLIENT_ID];

  components HplMsp430GeneralIOC as GIO;

  SpiC.SIMO -> GIO.UCA1SIMO;
  SpiC.SOMI -> GIO.UCA1SOMI;
  SpiC.CLK -> GIO.UCA1CLK;
}
