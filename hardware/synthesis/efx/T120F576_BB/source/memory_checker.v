/////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2013-2020 Efinix Inc. All rights reserved.
//
// Description:
// A simple design to validate DDR RAM read/write. 
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
/////////////////////////////////////////////////////////////////////////////////
`timescale 1ps/1ps
module memory_checker (

input axi_clk,
input rstn,
input start,
output [7:0] aid,
output reg [31:0] aaddr,
output reg [7:0] alen,
output reg [2:0] asize,
output reg [1:0] aburst,
output reg [1:0] alock,
output reg avalid,
input aready,
output reg atype,

output [7:0] wid,
output reg [255:0] wdata,
output  [31:0] wstrb,
output reg wlast,
output reg wvalid,
input wready,

input [7:0] rid,
input [255:0] rdata,
input rlast,
input rvalid,
output reg rready,
input [1:0] rresp,

input [7:0] bid,
input bvalid,
output reg bready,

output reg fail,
output reg done,
output reg [3:0] states,
output reg [255:0] obs_rdata_exp,
output reg [255:0] obs_rdata_det

);

assign aid = 8'h00;
assign wstrb = 32'hFFFFFFFF;
assign wid = 8'h00;

parameter ALEN = 23;
parameter ASIZE = 5;
parameter START_ADDR = 32'h00000000; 
parameter STOP_ADDR = 32'h00100000;
parameter ADDR_OFFSET = (ALEN + 1)*32;
parameter COMPARE_WIDTH = 256;
//Main states
localparam
	IDLE = 4'b0000, 
	WRITE_ADDR = 4'b0001,
	PRE_WRITE = 4'b0010,
	WRITE = 4'b0011,
	POST_WRITE = 4'b0100,
	READ_ADDR = 4'b0101,
	PRE_READ = 4'b0110,
	READ_COMPARE = 4'b0111,
	POST_READ = 4'b1000,
	DONE = 4'b1001;

//reg [3:0] states, nstates;
reg [3:0] nstates;
reg bvalid_done;
reg [1:0] start_sync;
reg [8:0] write_cnt, read_cnt;
reg [255:0] rdata_store;
reg wburst_done, rburst_done, write_done, read_done;
always @(posedge axi_clk or negedge rstn) begin
	if (!rstn) begin
		start_sync <= 2'b00;
	end else begin
		start_sync[0] <= start;
		start_sync[1] <= start_sync[0];
	end
end

always @(posedge axi_clk or negedge rstn) begin
 	if (!rstn) begin
	states <= IDLE;
	end else begin
	states <= nstates;
	end
end

always @(states or start_sync[1] or write_cnt or rburst_done or write_done or read_done or bvalid_done or aready) begin
	case(states) 
	IDLE 	   : if (start_sync[1]) 			nstates = WRITE_ADDR;
	             else					nstates = IDLE;
	WRITE_ADDR : if (aready)				nstates = PRE_WRITE;
		     else					nstates = WRITE_ADDR;
	PRE_WRITE  : 						nstates = WRITE;
	WRITE	   : if (write_cnt == 9'd0)			nstates = POST_WRITE;
		     else		 			nstates = WRITE;
	POST_WRITE : if (write_done & bvalid_done) 		nstates = READ_ADDR;
		     else if (bvalid_done)			nstates = WRITE_ADDR;
		     else					nstates = POST_WRITE;
	READ_ADDR  : if (aready) 				nstates = PRE_READ;
		     else					nstates = READ_ADDR;
	PRE_READ   :						nstates = READ_COMPARE;
	READ_COMPARE  : if (rburst_done) 			nstates = POST_READ;
			else					nstates = READ_COMPARE;
	POST_READ  :	if (read_done) 				nstates = DONE;
			else					nstates = READ_ADDR;
	DONE	   : 						nstates = DONE;
	default							nstates = IDLE;
	endcase
end

always @(posedge axi_clk or negedge rstn) begin
	if (!rstn) begin
		aaddr <= START_ADDR;
		avalid <= 1'b0;
		atype <= 1'b0;
		aburst <= 2'b00;
		asize <= 3'b000;
		alen <= 8'd0;
		alock <= 2'b00;
		wvalid <= 1'b0;
		write_cnt <= ALEN + 1;
		write_done <= 1'b0;
		wdata <= 256'd0;
		wburst_done <= 1'b0;
		wlast <= 1'b0;
		bready <= 1'b0;
		fail <= 1'b0;
		done <= 1'b0;
		rready <= 1'b0;
		bvalid_done <=1'b0;
		obs_rdata_det <= 256'h0;
		obs_rdata_exp <= 256'h0;
	end else begin
		if (states == IDLE) begin
	                aaddr <= START_ADDR;
	                avalid <= 1'b0;
        	        atype <= 1'b0;
               	 	aburst <= 2'b00;
                	asize <= 3'b000;
                	alen <= 8'd0;
                	alock <= 2'b00;
                	wvalid <= 1'b0;
                	write_cnt <= ALEN + 1;
                	wdata <= 256'd0;
                	wburst_done <= 1'b0;
                	wlast <= 1'b0;
                	bready <= 1'b0;
			rready <= 1'b0;
			bvalid_done <= 1'b0;
			fail <= 1'b0;
			done <= 1'b0;
		end
		if (states == WRITE_ADDR) begin
			avalid <= 1'b1;
			atype <= 1'b1;
			asize <= ASIZE;
			alen <= ALEN;
			aburst <= 2'b01;
			alock <= 2'b00;
			wvalid <= 1'b0;
			write_cnt <= ALEN + 1;
			wburst_done <= 1'b0;
			bvalid_done <= 1'b0;
			bready <= 1'b0;
			rready <= 1'b0;
			done <= 1'b0;
			fail <= 1'b0;
		end
		if (states == PRE_WRITE) begin
			avalid <= 1'b0;
			atype <= 1'b0;
			wvalid <= 1'b1;
			wdata <= {aaddr, ~aaddr, {8{~write_cnt[7:0]}}, ~aaddr, aaddr, {8{write_cnt[7:0]}}};
			bready <= 1'b1;
			write_cnt <= write_cnt - 1;
		end
		if (states == WRITE) begin
			if (wready == 1'b1) begin
                  		wdata <= {aaddr, ~aaddr, {8{~write_cnt[7:0]}}, ~aaddr, aaddr, {8{write_cnt[7:0]}}};
				if (write_cnt == 9'd0) begin
				wburst_done <= 1'b1;
				wlast <= 1'b0;
				wvalid <= 1'b0;
					if (aaddr >= STOP_ADDR) begin
					write_done <= 1'b1;
					end else begin
					write_done <= 1'b0;
					end
				end if (write_cnt == 9'd1) begin
					wlast <= 1'b1;
					write_cnt <= write_cnt - 1;
				end else begin
				write_cnt <= write_cnt - 1;
				end
			end
		end
		if (states == POST_WRITE) begin
			if (write_done) begin
				aaddr <= START_ADDR;
			end else begin
				if (bvalid) begin
				aaddr <= aaddr + ADDR_OFFSET;
				end
			end
			if (wready == 1'b1) begin
				wlast <= 1'b0;	
				wvalid <= 1'b0;	
			end
			if (bvalid) begin
				bvalid_done <= 1'b1;
				bready <= 1'b0;
			end
		end
		if (states == READ_ADDR) begin
			avalid <= 1'b1;
			read_cnt <= ALEN + 1;
				
		end
		if (states == PRE_READ) begin
			avalid <= 1'b0;
			rburst_done <= 1'b0;
                        rdata_store <= {aaddr, ~aaddr, {8{~read_cnt[7:0]}},~aaddr,aaddr,{8{read_cnt[7:0]}}};
			read_cnt <= read_cnt - 1'b1;
		end
		if (states == READ_COMPARE) begin
			rready <= 1'b1;
			if (read_cnt != 9'd0) begin
			if (rvalid == 1'b1) begin
                        rdata_store <= {aaddr, ~aaddr, {8{~read_cnt[7:0]}},~aaddr,aaddr,{8{read_cnt[7:0]}}};
			read_cnt <= read_cnt - 1'b1;
//				if (rdata != rdata_store) begin
				if (rdata[COMPARE_WIDTH-1:0] != rdata_store[COMPARE_WIDTH-1:0]) begin
					fail <= 1'b1;
					obs_rdata_exp <= rdata_store;
					obs_rdata_det <= rdata;
					`ifdef EFX_SIM
					$display("ERROR!! Read mismatch : read = 0x%x, expected = 0x%x",rdata,rdata_store);
					`endif 
				end else begin
					`ifdef EFX_SIM
					$display("Read match: read = 0x%x, expected = 0x%x",rdata,rdata_store);
					`endif
				end
	
			end
			end
			if (read_cnt == 9'd0) begin
	                        if (rvalid == 1'b1) begin
                                       if (rdata[COMPARE_WIDTH-1:0] != rdata_store[COMPARE_WIDTH-1:0]) begin
                                                fail <= 1'b1;
												obs_rdata_exp <= rdata_store;
												obs_rdata_det <= rdata;
                                                `ifdef EFX_SIM
                                                $display("ERROR!! Read mismatch : read = 0x%x, expected = 0x%x",rdata,rdata_store);
                                                `endif
                                        end else begin
                                                `ifdef EFX_SIM
                                                $display("Read match: read = 0x%x, expected = 0x%x",rdata,rdata_store);
                                                `endif
                                        end


					if (aaddr >= STOP_ADDR) begin
						read_done <= 1'b1;
					end else begin
						read_done <= 1'b0;
					end
					rburst_done <= 1'b1;
				end
			end	
		end
		if (states == POST_READ) begin
			aaddr <= aaddr + ADDR_OFFSET;
			rready <= 1'b1;
		end
		if (states == DONE) begin
			done <= 1'b1;
		end
	end

end

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
