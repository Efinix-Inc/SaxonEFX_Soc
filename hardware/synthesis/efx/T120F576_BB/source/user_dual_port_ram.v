/////////////////////////////////////////////////////////////////////////////
////
//// Copyright (C) 2013-2020 Efinix Inc. All rights reserved.
////
//// Description:
//// A dual port ram 
////
//// Language:  Verilog 2001
////
////
//------------------------------------------------------------------------------
//// REVISION:
////  $Snapshot: $
////  $Id:$
////
//// History:
//// 1.0 Initial Release. 
///////////////////////////////////////////////////////////////////////////////////

module user_dual_port_ram
#(
	parameter DATA_WIDTH	= 8,
	parameter ADDR_WIDTH	= 9,
	parameter OUTPUT_REG	= "TRUE",
	parameter RAM_INIT_FILE	= ""
)
(
	input [(DATA_WIDTH-1):0] wdata,
	input [(ADDR_WIDTH-1):0] waddr, raddr,
	input we, wclk, re, rclk,
	output [(DATA_WIDTH-1):0] rdata
);

	localparam MEMORY_DEPTH = 2**ADDR_WIDTH;
	localparam MAX_DATA = (1<<ADDR_WIDTH)-1;
	
	reg [DATA_WIDTH-1:0] ram[MEMORY_DEPTH-1:0];
	reg [DATA_WIDTH-1:0] r_rdata_1P;
	reg [DATA_WIDTH-1:0] r_rdata_2P;
	
	integer i;
	initial
	begin
	// By default the Efinix memory will initialize to 0
		if (RAM_INIT_FILE != "")
		begin
			$readmemh(RAM_INIT_FILE, ram);
		end
	end
	
	always @ (posedge wclk)
		if (we)
		ram[waddr] <= wdata;
	
	always @ (posedge rclk)
	begin
		if (re)
			r_rdata_1P <= ram[raddr];
		r_rdata_2P <= r_rdata_1P;
	end
	
	generate
		if (OUTPUT_REG == "TRUE")
			assign	rdata = r_rdata_2P;
		else
			assign	rdata = r_rdata_1P;
	endgenerate

endmodule

//////////////////////////////////////////////////////////////////////////////
// Copyright (C) 2013-2020 Efinix Inc. All rights reserved.
//
// This   document  contains  proprietary information  which   is
// protected by  copyright. All rights  are reserved.  This notice
// refers to original work by Efinix, Inc. which may be derivitive
// of other work distributed under license of the authors.  In the
// case of derivative work, nothing in this notice overrides the
// original author's license agreement.  Where applicable, the 
// original license agreement is included in it's original 
// unmodified form immediately below this header.
//
// WARRANTY DISCLAIMER.  
//     THE  DESIGN, CODE, OR INFORMATION ARE PROVIDED “AS IS” AND 
//     EFINIX MAKES NO WARRANTIES, EXPRESS OR IMPLIED WITH 
//     RESPECT THERETO, AND EXPRESSLY DISCLAIMS ANY IMPLIED WARRANTIES, 
//     INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF 
//     MERCHANTABILITY, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR 
//     PURPOSE.  SOME STATES DO NOT ALLOW EXCLUSIONS OF AN IMPLIED 
//     WARRANTY, SO THIS DISCLAIMER MAY NOT APPLY TO LICENSEE.
//
// LIMITATION OF LIABILITY.  
//     NOTWITHSTANDING ANYTHING TO THE CONTRARY, EXCEPT FOR BODILY 
//     INJURY, EFINIX SHALL NOT BE LIABLE WITH RESPECT TO ANY SUBJECT 
//     MATTER OF THIS AGREEMENT UNDER TORT, CONTRACT, STRICT LIABILITY 
//     OR ANY OTHER LEGAL OR EQUITABLE THEORY (I) FOR ANY INDIRECT, 
//     SPECIAL, INCIDENTAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES OF ANY 
//     CHARACTER INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF 
//     GOODWILL, DATA OR PROFIT, WORK STOPPAGE, OR COMPUTER FAILURE OR 
//     MALFUNCTION, OR IN ANY EVENT (II) FOR ANY AMOUNT IN EXCESS, IN 
//     THE AGGREGATE, OF THE FEE PAID BY LICENSEE TO EFINIX HEREUNDER 
//     (OR, IF THE FEE HAS BEEN WAIVED, $100), EVEN IF EFINIX SHALL HAVE 
//     BEEN INFORMED OF THE POSSIBILITY OF SUCH DAMAGES.  SOME STATES DO 
//     NOT ALLOW THE EXCLUSION OR LIMITATION OF INCIDENTAL OR 
//     CONSEQUENTIAL DAMAGES, SO THIS LIMITATION AND EXCLUSION MAY NOT 
//     APPLY TO LICENSEE.
//
/////////////////////////////////////////////////////////////////////////////


