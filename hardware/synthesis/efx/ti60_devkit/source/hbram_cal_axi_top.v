////////////////////////////////////////////////////////////////////////////
//           _____       
//          / _______    Copyright (C) 2013-2021 Efinix Inc. All rights reserved.
//         / /       \   
//        / /  ..    /   hbram_cal_axi_top.v
//       / / .'     /    
//    __/ /.'      /     Description:
//   __   \       /      AXI top file for hyper ram controller (with calibration)
//  /_/ /\ \_____/ /     
// ____/  \_______/      
//
// ***********************************************************************
// Revisions:
// 1.0 Initial rev
//
// ***********************************************************************
module hbram_cal_axi_top #(
	parameter	 RAM_DBW	= 8,
	parameter	 RAM_ABW	= 25,
	parameter [15:0] CFG_CR0	= 0,
	parameter [15:0] CFG_CR1	= 0,
	parameter	 AXI_DBW	= 32,
	parameter        AXI_AWR_DEPTH =  16,
	parameter        AXI_W_DEPTH   =  256,
	parameter        AXI_R_DEPTH	= 256,
	parameter	 DQIN_MODE	= "",
	parameter        RDO_DELAY      = 4,	
	parameter [4:0]	 CAL_CLK_CH	= 5'b00001,
	parameter	 CAL_MODE	= 0,
	parameter	 CAL_DQ_STEPS	= 8,
	parameter 	 CAL_RWDS_STEPS	= 8,
	parameter	 CAL_BYTES	= 'h100,
	parameter	 TCYC		= 100000,
	parameter 	 TCSM		= 4000000,
	parameter	 TVCS		= 150000000,
	parameter	 TRH		= 200000,
	parameter	 TRTR		= 40000
) (
	input				rst,
	input				ram_clk,
	input				ram_clk_cal,
	input				io_axi_clk,
	input                   	io_arw_valid,
        output                  	io_arw_ready,
        input   [31:0]        		io_arw_payload_addr,
        input   [7:0]         		io_arw_payload_id,
        input   [7:0]         		io_arw_payload_len,
        input   [2:0]         		io_arw_payload_size,
        input   [1:0]         		io_arw_payload_burst,
        input   [1:0]         		io_arw_payload_lock,
        input                 		io_arw_payload_write,
        input   [7:0]         		io_w_payload_id,
        input                 		io_w_valid,
        output                		io_w_ready,
        input   [AXI_DBW-1:0]      	io_w_payload_data,
        input   [(AXI_DBW/8)-1:0]  	io_w_payload_strb,
        input                 		io_w_payload_last,
        output                		io_b_valid,
        input                 		io_b_ready,
        output  [7:0]         		io_b_payload_id,
        output                		io_r_valid,
        input                 		io_r_ready,
        output  [AXI_DBW-1:0]     	io_r_payload_data,
        output  [7:0] 		 	io_r_payload_id,
        output  [1:0]         		io_r_payload_resp,
        output                  	io_r_payload_last,
	output				hbc_cal_SHIFT_ENA,
	output	[2:0]			hbc_cal_SHIFT,
	output	[4:0]			hbc_cal_SHIFT_SEL,
	output	[15:0]			hbc_debug_info,
     	output                        	hbc_rst_n,
     	output                        	hbc_cs_n,
     	output  [RAM_DBW/8-1:0]         hbc_pcs_p_HI,
     	output  [RAM_DBW/8-1:0]         hbc_pcs_p_LO,
     	output  [RAM_DBW/8-1:0]         hbc_pcs_n_HI,
     	output  [RAM_DBW/8-1:0]         hbc_pcs_n_LO,
     	output                        	hbc_ck_p_HI,
     	output                        	hbc_ck_p_LO,
     	output                        	hbc_ck_n_HI,
     	output                        	hbc_ck_n_LO,
     	output  [RAM_DBW/8-1:0]         hbc_rwds_OUT_HI,
     	output  [RAM_DBW/8-1:0]         hbc_rwds_OUT_LO,
     	input   [RAM_DBW/8-1:0]        	hbc_rwds_IN_HI,
     	input   [RAM_DBW/8-1:0]        	hbc_rwds_IN_LO,
     	output  [RAM_DBW/8-1:0]         hbc_rwds_OE,
     	output  [RAM_DBW-1:0]           hbc_dq_OUT_HI,
     	output  [RAM_DBW-1:0]           hbc_dq_OUT_LO,
     	input   [RAM_DBW-1:0]           hbc_dq_IN_HI,
     	input   [RAM_DBW-1:0]           hbc_dq_IN_LO,
     	output  [RAM_DBW-1:0]           hbc_dq_OE,
	output			        hbc_cal_pass

);
/////////////////////////////////////////////////////////////////////////////////
localparam DQ_DLY_W       = $clog2(CAL_DQ_STEPS);
localparam RWDS_DLY_W 	  = $clog2(CAL_RWDS_STEPS);
localparam [47:0] CR0W_CA = {8'h00, 8'h00, 8'h00, 8'h01, 8'h00, 8'h60};
localparam [47:0] CR1W_CA = {8'h01, 8'h00, 8'h00, 8'h01, 8'h00, 8'h60};
//hyperbus controller host Signals
wire				 h_cal_en;
wire                         	 h_req;
wire                         	 h_last;
wire     [RAM_ABW-1:0]       	 h_addr;
wire                         	 h_btype;
wire                         	 h_atype;
wire                         	 h_rwen;
wire                         	 h_mrdy;
wire     [RAM_DBW/4-1:0]     	 h_wdm;
wire     [RAM_DBW*2-1:0]     	 h_wdata;
wire                         	 h_wrdy;
wire     [RAM_DBW*2-1:0]     	 h_rdata;
wire                         	 h_rdav;
wire				 h_ctc;
wire				 h_pause;
//reset synchronizer
reg	 [2:0]			 axi_rst_sync;
reg	 [2:0]			 ram_rst_sync;
wire			     	 io_axi_rstn,
       				 ram_rstn;
wire	 [RWDS_DLY_W-1:0]	 rwds_delay_w;
wire	 [DQ_DLY_W*RAM_DBW-1:0]  dq_delay_w;
reg 	 [RWDS_DLY_W-1:0]     	 hbc_rwds_delay;
reg 	 [DQ_DLY_W*RAM_DBW-1:0]  hbc_dq_delay ;
/////////////////////////////////////////////////////////////////////////////////
//reset
always@ (posedge io_axi_clk or posedge rst)
begin
	if(rst)
		axi_rst_sync <= 'h0;
	else
		axi_rst_sync <= {axi_rst_sync[1:0], 1'b1};
end

always@ (posedge ram_clk or posedge rst)
begin
	if(rst)
		ram_rst_sync <= 'h0;
	else
		ram_rst_sync <= {ram_rst_sync[1:0], 1'b1};
end

assign io_axi_rstn = axi_rst_sync[2];
assign ram_rstn    = ram_rst_sync[2];
//calibration status
assign hbc_cal_pass     = h_mrdy;

always@(posedge ram_clk) 
begin
	hbc_rwds_delay <= rwds_delay_w;
	hbc_dq_delay   <= dq_delay_w;	
end

assign hbc_cal_SHIFT_ENA	= h_cal_en;
assign hbc_cal_SHIFT		= hbc_rwds_delay;
assign hbc_cal_SHIFT_SEL	= CAL_CLK_CH;

/////////////////////////////////////////////////////////////////////////////////
hbram_axi_wrapper #(
	.RAM_DBW  		(RAM_DBW		),
	.RAM_ABW 		(RAM_ABW		),
	.AXI_DBW  		(AXI_DBW		),
        .AXI_AWR_DEPTH		(AXI_AWR_DEPTH		),
        .AXI_W_DEPTH		(AXI_W_DEPTH		),
        .AXI_R_DEPTH		(AXI_R_DEPTH		)
) hbram_axi_wrapper_inst (

	.ram_clk              	(ram_clk      		), 
	.ram_rstn            	(ram_rstn 		), 
	.io_axi_clk		(io_axi_clk		),
	.io_axi_rstn		(io_axi_rstn		),
	.io_arw_valid		(io_arw_valid		),
        .io_arw_ready		(io_arw_ready		),
        .io_arw_payload_addr	(io_arw_payload_addr	),
        .io_arw_payload_id	(io_arw_payload_id	),
        .io_arw_payload_len	(io_arw_payload_len	),
        .io_arw_payload_size	(io_arw_payload_size	),
        .io_arw_payload_burst	(io_arw_payload_burst	),
        .io_arw_payload_lock	(io_arw_payload_lock	),
        .io_arw_payload_write	(io_arw_payload_write	),
        .io_w_payload_id	(io_w_payload_id	),
        .io_w_valid		(io_w_valid		),
        .io_w_ready		(io_w_ready		),
        .io_w_payload_data	(io_w_payload_data	),
        .io_w_payload_strb	(io_w_payload_strb	),
        .io_w_payload_last	(io_w_payload_last	),
        .io_b_valid		(io_b_valid		),
        .io_b_ready		(io_b_ready		),
        .io_b_payload_id	(io_b_payload_id	),
        .io_r_valid		(io_r_valid		),
        .io_r_ready		(io_r_ready		),
        .io_r_payload_data	(io_r_payload_data	),
        .io_r_payload_id	(io_r_payload_id	),
        .io_r_payload_resp	(io_r_payload_resp	),
        .io_r_payload_last	(io_r_payload_last	),
	.h_ctc			(h_ctc			),
	.h_pause		(h_pause		),
     	.h_req			(h_req			), 
     	.h_last			(h_last			), 
     	.h_addr			(h_addr			), 
     	.h_btype		(h_btype		), 
     	.h_atype		(h_atype		), 
     	.h_rwen			(h_rwen			), 
     	.h_mrdy			(h_mrdy		        ), 
     	.h_wdm			(h_wdm			), 
     	.h_wdata		(h_wdata		), 
	.h_wrdy			(h_wrdy			), 
     	.h_rdata		(h_rdata		), 
     	.h_rdav			(h_rdav			) 
);

generate 
//soft ddio
wire 	 [RAM_DBW-1:0] 	     	 hbc_dq_IN_delay;
wire 	 [RAM_DBW-1:0] 	     	 hbc_dq_IN_LO_ddio;
wire 	 [RAM_DBW-1:0] 	     	 hbc_dq_IN_HI_ddio;
wire	 [RAM_DBW/8-1:0]	 int_rwds_IN_delay;

if (CAL_MODE == 1)
begin
	hbram_cal_controller_top #(
	.CAL_MODE		(CAL_MODE		),
	.CAL_BYTES		(CAL_BYTES		),
	.RAM_DBW  		(RAM_DBW		),
	.RAM_ABW 		(RAM_ABW		),
	.CFG_CR0		(CFG_CR0		),
	.CFG_CR1		(CFG_CR1		),
	.CR0W_CA		(CR0W_CA		),
	.CR1W_CA		(CR1W_CA		),
	.DQIN_MODE		(DQIN_MODE		),
	.RDO_DELAY		(RDO_DELAY 		),
	.TCYC			(TCYC			),
	.TCSM			(TCSM			),
	.TVCS			(TVCS			),
	.TRH			(TRH			),
	.TRTR			(TRTR			),
	.DQ_CAL_STEPS		(CAL_DQ_STEPS		),
	.DQ_DLY_W		(DQ_DLY_W		),
	.RWDS_CAL_STEPS 	(CAL_RWDS_STEPS		),
	.RWDS_DLY_W		(RWDS_DLY_W		)
	) hbram_cal_top_inst (
	.clk              	(ram_clk              ), 
	.rst_n            	(ram_rstn             ), 
	.h_rst_n          	(ram_rstn 	      ), 
	.h_cal_en		(h_cal_en	      ),
	.h_ctc			(h_ctc		      ),
	.h_pause		(h_pause	      ),
	.h_req            	(h_req         	      ),
	.h_last           	(h_last        	      ),
	.h_addr           	(h_addr        	      ),
	.h_btype          	(h_btype       	      ), 
	.h_atype          	(h_atype       	      ), 
	.h_rwen           	(h_rwen        	      ), 
	.h_mrdy           	(h_mrdy        	      ), 
	.h_wdm            	(h_wdm         	      ),
	.h_wdata          	(h_wdata       	      ),
	.h_wrdy           	(h_wrdy        	      ), 
	.h_rdata          	(h_rdata       	      ),
	.h_rdav           	(h_rdav        	      ), 
	.rwds_delay       	(rwds_delay_w         ),     
     	.dq_delay        	(dq_delay_w           ),
	.debug_info		(hbc_debug_info	      ),
	.hbc_rst_n        	(hbc_rst_n            ), 
	.hbc_cs_n         	(hbc_cs_n             ),
	.hbc_pcs_p_HI     	(hbc_pcs_p_HI         ),
	.hbc_pcs_p_LO     	(hbc_pcs_p_LO         ),
	.hbc_pcs_n_HI     	(hbc_pcs_n_HI         ),
	.hbc_pcs_n_LO     	(hbc_pcs_n_LO         ),
	.hbc_ck_p_HI      	(hbc_ck_p_HI          ),
	.hbc_ck_p_LO      	(hbc_ck_p_LO          ),
	.hbc_ck_n_HI      	(hbc_ck_n_HI          ),
	.hbc_ck_n_LO      	(hbc_ck_n_LO          ),
	.hbc_rwds_OUT_HI  	(hbc_rwds_OUT_HI      ),
	.hbc_rwds_OUT_LO  	(hbc_rwds_OUT_LO      ),
	.hbc_rwds_IN_HI      	(hbc_rwds_IN_HI       ),
	.hbc_rwds_IN_LO      	(		      ),
	.hbc_rwds_IN_delay	(int_rwds_IN_delay    ),
	.hbc_rwds_OE      	(hbc_rwds_OE          ),
	.hbc_dq_OUT_HI    	(hbc_dq_OUT_HI        ),
	.hbc_dq_OUT_LO    	(hbc_dq_OUT_LO        ),
	.hbc_dq_IN_HI     	(hbc_dq_IN_HI_ddio    ),
	.hbc_dq_IN_LO     	(hbc_dq_IN_LO_ddio    ),
	.hbc_dq_OE        	(hbc_dq_OE            )
	);
	
	genvar i,j,k;
	`ifndef SIM
	for (i=0; i< RAM_DBW/8; i=i+1)
	begin
		mux_delay mux_delay_rwd (
	      	   .in  (hbc_rwds_IN_HI[i]),
	     	   .s   (hbc_rwds_delay),
	      	   .out (int_rwds_IN_delay[i]),
	      	   .clk (ram_clk)
		);
	end
	
	for (j=0; j<RAM_DBW; j=j+1) 
	begin
		mux_delay mux_delay_dq (
	    	   .in  (hbc_dq_IN_HI[j]),
	    	   .s   (hbc_dq_delay[(j*$clog2(CAL_DQ_STEPS))+:$clog2(CAL_DQ_STEPS)]),
	    	   .out (hbc_dq_IN_delay[j]),
	    	   .clk (ram_clk)
		);
	end
	
	for (k=0; k< RAM_DBW/8; k=k+1)
	begin
	soft_iddio #(
		.MODE (DQIN_MODE)
	) dq_iddio_inst (
	      .clk         (int_rwds_IN_delay[k]),
	      .ddr_din     (hbc_dq_IN_delay  [k*8+7 -: 8]),
	      .ddr_din_HI  (hbc_dq_IN_HI_ddio[k*8+7 -: 8]),
	      .ddr_din_LO  (hbc_dq_IN_LO_ddio[k*8+7 -: 8])
	);
	end
	`else
	for (k=0; k< RAM_DBW/8; k=k+1)
	begin
	soft_iddio #(
		.MODE (DQIN_MODE)
	) dq_iddio_inst (
	      .clk         (hbc_rwds_IN_HI[k]),
	      .ddr_din     (hbc_dq_IN_HI[k*8+7 -: 8]),
	      .ddr_din_HI  (hbc_dq_IN_HI_ddio[k*8+7 -: 8]),
	      .ddr_din_LO  (hbc_dq_IN_LO_ddio[k*8+7 -: 8])
	);

	assign int_rwds_IN_delay[k] = hbc_rwds_IN_HI[k];
	end

	`endif
end	
else if (CAL_MODE == 2) 
begin
	hbram_cal_controller_top #(
	.CAL_MODE		(CAL_MODE		),
	.CAL_BYTES		(CAL_BYTES		),
	.RAM_DBW  		(RAM_DBW		),
	.RAM_ABW 		(RAM_ABW		),
	.CFG_CR0		(CFG_CR0		),
	.CFG_CR1		(CFG_CR1		),
	.CR0W_CA		(CR0W_CA		),
	.CR1W_CA		(CR1W_CA		),
	.DQIN_MODE		(DQIN_MODE		),
	.RDO_DELAY		(RDO_DELAY 		),
	.TCYC			(TCYC			),
	.TCSM			(TCSM			),
	.TVCS			(TVCS			),
	.TRH			(TRH			),
	.TRTR			(TRTR			),
	.DQ_CAL_STEPS		(CAL_DQ_STEPS		),
	.DQ_DLY_W		(DQ_DLY_W		),
	.RWDS_CAL_STEPS 	(CAL_RWDS_STEPS		),
	.RWDS_DLY_W		(RWDS_DLY_W		)
	) hbram_cal_top_inst (
	.clk              	(ram_clk              ), 
	.clk_cal		(ram_clk_cal	      ),
	.rst_n            	(ram_rstn             ), 
	.h_rst_n          	(ram_rstn 	      ), 
	.h_cal_en		(h_cal_en	      ),
	.h_ctc			(h_ctc		      ),
	.h_pause		(h_pause	      ),
	.h_req            	(h_req         	      ),
	.h_last           	(h_last        	      ),
	.h_addr           	(h_addr        	      ),
	.h_btype          	(h_btype       	      ), 
	.h_atype          	(h_atype       	      ), 
	.h_rwen           	(h_rwen        	      ), 
	.h_mrdy           	(h_mrdy        	      ), 
	.h_wdm            	(h_wdm         	      ),
	.h_wdata          	(h_wdata       	      ),
	.h_wrdy           	(h_wrdy        	      ), 
	.h_rdata          	(h_rdata       	      ),
	.h_rdav           	(h_rdav        	      ), 
	.rwds_delay       	(rwds_delay_w         ),     
     	.dq_delay        	(dq_delay_w           ),
	.debug_info		(hbc_debug_info	      ),
	.hbc_rst_n        	(hbc_rst_n            ), 
	.hbc_cs_n         	(hbc_cs_n             ),
	.hbc_pcs_p_HI     	(hbc_pcs_p_HI         ),
	.hbc_pcs_p_LO     	(hbc_pcs_p_LO         ),
	.hbc_pcs_n_HI     	(hbc_pcs_n_HI         ),
	.hbc_pcs_n_LO     	(hbc_pcs_n_LO         ),
	.hbc_ck_p_HI      	(hbc_ck_p_HI          ),
	.hbc_ck_p_LO      	(hbc_ck_p_LO          ),
	.hbc_ck_n_HI      	(hbc_ck_n_HI          ),
	.hbc_ck_n_LO      	(hbc_ck_n_LO          ),
	.hbc_rwds_OUT_HI  	(hbc_rwds_OUT_HI      ),
	.hbc_rwds_OUT_LO  	(hbc_rwds_OUT_LO      ),
	.hbc_rwds_IN_HI      	(hbc_rwds_IN_HI       ),
	.hbc_rwds_IN_LO      	(hbc_rwds_IN_LO       ),
	.hbc_rwds_IN_delay	(		      ),
	.hbc_rwds_OE      	(hbc_rwds_OE          ),
	.hbc_dq_OUT_HI    	(hbc_dq_OUT_HI        ),
	.hbc_dq_OUT_LO    	(hbc_dq_OUT_LO        ),
	.hbc_dq_IN_HI     	(hbc_dq_IN_HI         ),
	.hbc_dq_IN_LO     	(hbc_dq_IN_LO         ),
	.hbc_dq_OE        	(hbc_dq_OE            )
	);
end
endgenerate

endmodule
