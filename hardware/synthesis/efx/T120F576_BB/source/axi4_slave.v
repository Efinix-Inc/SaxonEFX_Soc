/////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2013-2020 Efinix Inc. All rights reserved.
//
// Description:
// A simple axi4 slave wrapper example design to interface with soc axi4
// signals. This example design includes a 4KB onchip-RAM
//
// Language:  Verilog 2001
//
// ------------------------------------------------------------------------------
// REVISION:
//  $Snapshot: $
//  $Id:$
//
// History:
// 1.0 Initial Release. 
// 1.1 fix array concatenate issue 
/////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module axi4_slave #(
	parameter ADDR_WIDTH = 32,
	parameter DATA_WIDTH = 32
) (
	//custom logic starts here
	output			axi_interrupt,
	//
	input			axi_aclk,
	input			axi_resetn,
	//AW
	input [7:0]		axi_awid,
	input [ADDR_WIDTH-1:0]	axi_awaddr,
	input [7:0]		axi_awlen,
	input [2:0]		axi_awsize,
	input [1:0]		axi_awburst,
	input			axi_awlock,
	input [3:0]		axi_awcache,
	input [2:0]		axi_awprot,
	input [3:0]		axi_awqos,
	input [3:0]		axi_awregion,
	input 			axi_awvalid,
	output			axi_awready,
	//W
	input [DATA_WIDTH-1:0]	axi_wdata,
	input [(DATA_WIDTH/8)-1:0] 
				axi_wstrb,
	input 			axi_wlast,
	input			axi_wvalid,
	output			axi_wready,
	//B
	output [7:0]		axi_bid,
	output [1:0]		axi_bresp,
	output 			axi_bvalid,
	input			axi_bready,
	//AR
	input [7:0]		axi_arid,
	input [ADDR_WIDTH-1:0]	axi_araddr,
	input [7:0]		axi_arlen,
	input [2:0]		axi_arsize,
	input [1:0]		axi_arburst,
	input 			axi_arlock,
	input [3:0]		axi_arcache,
	input [2:0]		axi_arprot,
	input [3:0]		axi_arqos,
	input [3:0]		axi_arregion,
	input 			axi_arvalid,
	output			axi_arready,
	//R
	output [7:0]		axi_rid,
	output [DATA_WIDTH-1:0]	axi_rdata,
	output [1:0]		axi_rresp,
        output 			axi_rlast,
	output			axi_rvalid,
	input			axi_rready	
);

///////////////////////////////////////////////////////////////////////////////
localparam [1:0]	IDLE  	= 3'h0,
			WR 	= 3'h1,
			WR_RESP = 3'h2,
			RD	= 3'h3;
		
reg [1:0] 		busState,
			busNext;
reg			awreadyReg,
			arreadyReg;
wire 			busReady,
			busWrite,
			busWriteResp,
			busRead;

reg  [7:0]		awidReg;
reg  [ADDR_WIDTH-1:0]	awaddrReg;
reg  [7:0]		awlenReg;
reg  [2:0]		awsizeReg;
reg  [1:0]		awburstReg,
  			awlockReg;
reg  [3:0]		awcacheReg;
reg  [2:0]		awprotReg;
reg  [3:0]		awqosReg;
reg  [3:0]		awregionReg;

reg  [7:0]		aridReg;
reg  [ADDR_WIDTH-1:0]	araddrReg;
reg  [7:0]		arlenReg;
reg  [2:0]		arsizeReg;
reg  [1:0]		arburstReg,
  			arlockReg;
reg  [3:0]		arcacheReg;
reg  [2:0]		arprotReg;
reg  [3:0]		arqosReg;
reg  [3:0]		arregionReg;


wire [31:0]		awaddr_wrap;
reg  [7:0]		decodeAwsize;

wire [31:0]		araddr_wrap;
reg  [7:0]		decodeArsize;

reg  [7:0]		bidReg;
reg  [1:0]		brespReg;
reg 			bvalidReg;

reg [7:0]		ridReg;
reg [1:0]		rrespReg;
reg [1:0]		rlastReg;
wire 			rvalidReg;
reg			rvalidReg2;
reg [7:0]		rdataCnt;

//custom logic
wire [7:0]  wdata [0:3];
wire	    wEnable[0:3];
wire [7:0]  rdata [0:3];
wire [31:0] data_o;
wire  	    data_o_en;

///////////////////////////////////////////////////////////////////////////////



	always@ (posedge axi_aclk or negedge axi_resetn)
	begin
		if(!axi_resetn)
			busState <= IDLE;
		else
			busState <= busNext;

	end

	always@ (*)
	begin
		busNext = busState;

		case(busState)
		IDLE:
		begin
			if(axi_awready)
				busNext = WR;
			else if(axi_arready)
				busNext = RD;
			else
				busNext = IDLE;
		end
		WR:
		begin
			if(axi_wlast)
				busNext = WR_RESP;
			else
				busNext = WR;
		end
		WR_RESP:
		begin
			if(axi_bready)
				busNext = IDLE;
			else
				busNext = WR_RESP;
		end
		RD:
		begin
			if(axi_rlast)
				busNext = IDLE;
			else
				busNext = RD;
		end
		default:
			busNext = IDLE;
		endcase
	end

	assign busReady     = (busState == IDLE);
	assign busWrite     = (busState == WR);
	assign busWriteResp = (busState == WR_RESP);
	assign busRead      = (busState == RD);

    //AW Control

	assign axi_awready = awreadyReg & axi_awvalid;

	always@ (posedge axi_aclk or negedge axi_resetn)
	begin
		if(!axi_resetn)
			awreadyReg <= 1'b0;
		else
		begin
			if(axi_awvalid && axi_wvalid && busReady)
				awreadyReg <= 1'b1;
			else
				awreadyReg <= 1'b0;	
		end

	end
    
	assign awaddr_wrap 	= (DATA_WIDTH/8) * awlenReg;
	assign awWrap 		= (awaddrReg & awaddr_wrap);

    //AW Info 
    	always@ (posedge axi_aclk)
	begin
		if(axi_awvalid) begin
			awidReg     <= axi_awid;
			awlenReg    <= axi_awlen;
			awsizeReg   <= axi_awsize;
			awburstReg  <= axi_awburst;
			awlockReg   <= axi_awlock;
			awcacheReg  <= axi_awcache;
			awprotReg   <= axi_awprot;
			awqosReg    <= axi_awqos;
			awregionReg <= axi_awregion;
		end
		else begin
			awidReg     <= awidReg;
			awlenReg    <= awlenReg;
			awsizeReg   <= awsizeReg;
			awburstReg  <= awburstReg;
			awlockReg   <= awlockReg;
			awcacheReg  <= awcacheReg;
			awprotReg   <= awprotReg;
			awqosReg    <= awqosReg;
			awregionReg <= awregionReg;
		end
	end

	always@ (awsizeReg)
	begin
		case(awsizeReg)
		3'h0:decodeAwsize    <= 8'd1;
		3'h1:decodeAwsize    <= 8'd2;
		3'h2:decodeAwsize    <= 8'd4;
		3'h3:decodeAwsize    <= 8'd8;
		3'h4:decodeAwsize    <= 8'd16;
		3'h5:decodeAwsize    <= 8'd32;
		3'h6:decodeAwsize    <= 8'd64;
		3'h7:decodeAwsize    <= 8'd128;
		default:decodeAwsize <= 8'd1;
		endcase
	end

	always@ (posedge axi_aclk)
	begin
		if(axi_awvalid)
			awaddrReg   <= axi_awaddr;
		else if (busWrite) begin
			case(awburstReg)
			2'b00://fixed burst
			awaddrReg <= awaddrReg;
			2'b01://incremental burst
			awaddrReg <= awaddrReg + decodeAwsize;
			2'b10://wrap burst
			begin
				if(awWrap)
					awaddrReg <= awaddrReg - awaddr_wrap;
				else
					awaddrReg <= awaddrReg + decodeAwsize;
			end
			default:
			awaddrReg <= awaddrReg;
			endcase
		end
	end
    //W operation
    	assign axi_wready = busWrite;

    //B Response
	assign axi_bid = bidReg;
	assign axi_bresp = brespReg;
	assign axi_bvalid = bvalidReg;

    	always@ (posedge axi_aclk)
	begin
		if(busWriteResp) begin
			bidReg   <= awidReg;
			brespReg <= 2'b00;
			bvalidReg<= 1'b1;
		end
		else begin
			bidReg   <= 8'd0;
			brespReg <= 2'b00;
			bvalidReg<= 1'b0;
		end
	end

   //AR Control
	assign axi_arready = arreadyReg & axi_arvalid;

	always@ (posedge axi_aclk or negedge axi_resetn)
	begin
		if(!axi_resetn)
			arreadyReg <= 1'b0;
		else
		begin
			if(axi_arvalid && busState == IDLE)
				arreadyReg <= 1'b1;
			else
				arreadyReg <= 1'b0;	
		end

	end

	assign araddr_wrap 	= (DATA_WIDTH/8) * arlenReg;
	assign arWrap 		= (araddrReg & araddr_wrap);

    //AR Info 
    	always@ (posedge axi_aclk)
	begin
		if(axi_arvalid) begin
			aridReg     <= axi_arid;
			arlenReg    <= axi_arlen;
			arsizeReg   <= axi_arsize;
			arburstReg  <= axi_arburst;
			arlockReg   <= axi_arlock;
			arcacheReg  <= axi_arcache;
			arprotReg   <= axi_arprot;
			arqosReg    <= axi_arqos;
			arregionReg <= axi_arregion;
		end
		else begin
			aridReg     <= aridReg;
			arlenReg    <= arlenReg;
			arsizeReg   <= arsizeReg;
			arburstReg  <= arburstReg;
			arlockReg   <= arlockReg;
			arcacheReg  <= arcacheReg;
			arprotReg   <= arprotReg;
			arqosReg    <= arqosReg;
			arregionReg <= arregionReg;
		end
	end

	always@ (arsizeReg)
	begin
		case(arsizeReg)
		3'h0:decodeArsize    <= 8'd1;
		3'h1:decodeArsize    <= 8'd2;
		3'h2:decodeArsize    <= 8'd4;
		3'h3:decodeArsize    <= 8'd8;
		3'h4:decodeArsize    <= 8'd16;
		3'h5:decodeArsize    <= 8'd32;
		3'h6:decodeArsize    <= 8'd64;
		3'h7:decodeArsize    <= 8'd128;
		default:decodeArsize <= 8'd1;
		endcase
	end

	always@ (posedge axi_aclk)
	begin
		if(axi_arvalid)
			araddrReg   <= axi_araddr;
		else if (rvalidReg) begin
			case(arburstReg)
			2'b00://fixed burst
			araddrReg <= araddrReg;
			2'b01://incremental burst
			araddrReg <= araddrReg + decodeArsize;
			2'b10://wrap burst
			begin
				if(arWrap)
					araddrReg <= araddrReg - araddr_wrap;
				else
					araddrReg <= araddrReg + decodeArsize;
			end
			default:
			araddrReg <= araddrReg;
			endcase
		end
	end

    // R Operation

	assign axi_rid    = ridReg;
	assign axi_rresp  = rrespReg;
	assign axi_rvalid = rvalidReg2 & rvalidReg;
	assign axi_rlast  = axi_rready? 
				(arlenReg == 2'b00) ? axi_rvalid 
				: (rdataCnt == arlenReg + 1'b1) 
				:1'b0;
	assign axi_rdata  = data_o;

    	always@ (posedge axi_aclk)
	begin
		if(busRead) begin
			ridReg    <= aridReg;
			rrespReg  <= 2'b00;
		end
		else begin
			ridReg   <= 8'd0;
			rrespReg <= 2'b00;
		end
	end

	assign rvalidReg = busRead && axi_rready;

	always@ (posedge axi_aclk)
	begin
		rvalidReg2 <= rvalidReg;
	end


	always@ (posedge axi_aclk or negedge axi_resetn)
	begin
		if(!axi_resetn)
			rdataCnt <= 8'd0;
		else begin
			if(busRead && rvalidReg2)
				rdataCnt <= rdataCnt + 1'b1;	
			else if (busRead && !rvalidReg2)
				rdataCnt <= rdataCnt;
			else
				rdataCnt <= 'd0;
		end
	end
	


    //custom logic starts here
    	assign axi_interrupt = 1'b0;	
	assign data_o_en = rvalidReg;
 	genvar i;
	generate
		for(i=0;i < (DATA_WIDTH/8); i = i + 1) begin
	
		
		assign wdata[i] = axi_wdata[(i*8+7) -: 8] & {8{axi_wstrb[i]}};
		assign data_o[(i*8+7) -: 8] = rdata[i];
		assign wEnable[i] = axi_wready & axi_wstrb[i];

	 	user_dual_port_ram #(
			.DATA_WIDTH (8),
			.ADDR_WIDTH (9),
			.OUTPUT_REG ("FALSE")
						 
	 	) user_ram (
			.wdata 	(wdata[i]),
			.waddr	(awaddrReg[10:2]), 
			.raddr	(araddrReg[10:2]),
			.we	(wEnable[i]), 
			.wclk	(axi_aclk), 
			.re	(data_o_en), 
			.rclk	(axi_aclk),
			.rdata	(rdata[i])
	 	);
		end
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
