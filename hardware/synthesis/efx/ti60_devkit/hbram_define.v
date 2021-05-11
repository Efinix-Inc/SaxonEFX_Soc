////////////////////////////////////////////////////////////////////////////
//           _____       
//          / _______    Copyright (C) 2013-2021 Efinix Inc. All rights reserved.
//         / /       \   
//        / /  ..    /   hbram_define.v
//       / / .'     /    
//    __/ /.'      /     Description:
//   __   \       /      hyper ram controller definitions
//  /_/ /\ \_____/ /     
// ____/  \_______/      
//
// ***********************************************************************
// Revisions:
// 1.0 Initial rev
//
// ***********************************************************************

//SOC define
//`define SOFT_TAP			   //Debugger tap type for soc only.
//System parameter define
`define AXI_DBW		 128		   //Define Axi bus data bit width. 128/64/32
`define AXI_AWR_DEPTH	 16		   //Define fifo depth for AWR channel
`define AXI_W_DEPTH      256		   //Define fifo depth for W channel
`define AXI_R_DEPTH	 256		   //Define fifo depth for R channel
`define MHZ              200               //Define work frequency:100/166/200
`define RAM_DBW		 16		   //Define Ram bus data bit width. 16/8
`define RAM_ABW          25                //x8 (16bits word address)
					   //32Mb  -> 22
					   //64Mb  -> 23
					   //128Mb -> 24
					   //256Mb -> 25
					   //x16 (32bits word address)
					   //32Mb  -> 22
					   //64Mb  -> 23
					   //128Mb -> 24
					   //256Mb -> 25

//Calibration default parameter
`define DQIN_MODE 	 "RESYNC"    	   //define soft ddio register mode: "RESYNC" or "NORMAL"
					   //Ignore when calibration mode turned on.
`define CAL_CLK_CH       5'b00100	   //PLL Clock output channel for hard calibration

`ifdef SIM
   `define DQIN_MODE 	  "RESYNC"
   `define AXI_DBW	  `SIM_AXI_DBW
   `define RAM_DBW        `SIM_RAM_DBW
`endif

/////////////////////////////////////////////////////////////////////////////////
//[Initial Configuration Register 0 define]
/*

DPD  = Deep Power Down Mode Enable
1    - Normal operation (default). HyperRAM will automatically set this value to “1” after DPD exit
0    - Writing 0 causes the device to enter Deep Power Down

ODS  = Output Drive Strength
000  - 34 ohms (default)
001  - 115 ohms
010  - 67 ohms
011  - 46 ohms
100  - 34 ohms
101  - 27 ohms
110  - 22 ohms
111  - 19 ohms

ILC  = Initial Latency Count
0000 - 5 Clock Latency @ 133 MHz Max Frequency
0001 - 6 Clock Latency @ 166 MHz Max Frequency
0010 - 7 Clock Latency @ 200 MHz/166 MHz Max Frequency (default)
1110 - 3 Clock Latency @ 85 MHz Max Frequency
1111 - 4 Clock Latency @ 104 MHz Max Frequency

FLE  = Fixed Latency Enable
0    - Variable Latency - 1 or 2 times Initial Latency depending on RWDS duringCA cycles.
1    - Fixed 2 times Initial Latency (default)

HBE  = Hybrid Burst Enable
0    : Wrapped burst sequence to follow hybrid burst sequencing
1    : Wrapped burst sequence in legacy wrapped burst manner (default)

WBL  = Wapped Burst Length
00   - 128 bytes
01   - 64 bytes
10   - 16 bytes
11   - 32 bytes (default)
*/
`define DPD              1'b1
`define ODS              3'b000
`define ILC              4'b0010 
`define FLE              1'b1
`define HBE              1'b1
`define WBL              2'b11 
`define CR0              {`DPD,`ODS,4'b1111,`ILC,`FLE,`HBE,`WBL}

/////////////////////////////////////////////////////////////////////////////////
//[Initial Configuration Register 1 define]

/*
MCT = Master Clock Type
1   - Single-Ended - CK (default)
0   - Differential - CK#, CK

HSE = Hybrid Sleep Enable
1   - Causes the device to enter Hybrid Sleep State
0   - Normal operation (default)

PAR = Partial Array Refresh
000 - Full Array (default)
001 - Bottom 1/2 Array
010 - Bottom 1/4 Array
011 - Bottom 1/8 Array
100 - none
101 - Top 1/2 Array
110 - Top 1/4 Array
111 - Top 1/8 Array
*/

`define MCT              1'b1
`define HSE              1'b0
`define PAR              3'b000  
`define CR1              {9'h1ff,`MCT,`HSE,`PAR,2'b01}

/////////////////////////////////////////////////////////////////////////////////
//[Timing parameter define]
`define tCYC             (1000000/`MHZ)
`define tCSM             4000000       //ps,Chip Select Maximum Low Time
`define tVCS             150000000     //ps,VCC and VCCQ ≥ minimum and RESET# HIGH to first access
`define tRH              200000        //ps，Time between RESET# (HIGH) and CS# (LOW)
`define tRTR             40000         //ps, Read-Write Recovery Time            
 
