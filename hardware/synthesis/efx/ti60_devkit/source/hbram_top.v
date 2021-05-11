////////////////////////////////////////////////////////////////////////////
//           _____       
//          / _______    Copyright (C) 2013-2020 Efinix Inc. All rights reserved.
//         / /       \   
//        / /  ..    /   hbram_top.v
//       / / .'     /    
//    __/ /.'      /     Description:
//   __   \       /      Top wrapper file for hyper ram controller
//  /_/ /\ \_____/ /     
// ____/  \_______/      
//
// ***********************************************************************
// Revisions:
// 1.0 Initial rev
//
// ***********************************************************************

module hbram_top #(
	parameter	 RAM_DBW	= 8,
	parameter	 RAM_ABW	= 25,
	parameter [15:0] CFG_CR0	= 0,
	parameter [15:0] CFG_CR1	= 0,
	parameter	 AXI_DBW	= 32,
	parameter        AXI_AWR_DEPTH =  16,
	parameter        AXI_W_DEPTH   =  256,
	parameter        AXI_R_DEPTH	= 256,
	parameter	 DQIN_MODE	= "",
	parameter [4:0]	 CAL_CLK_CH	= 5'b00001,
	parameter	 TCYC		= 100000,
	parameter 	 TCSM		= 4000000,
	parameter	 TVCS		= 150000000,
	parameter	 TRH		= 200000,
	parameter	 TRTR		= 40000
) (
	input						rst,
	input						ram_clk,
	input						ram_clk_cal,
	input						io_axi_clk,
	input                   			io_arw_valid,
        output                  			io_arw_ready,
        input   [31:0]        				io_arw_payload_addr,
        input   [7:0]         				io_arw_payload_id,
        input   [7:0]         				io_arw_payload_len,
        input   [2:0]         				io_arw_payload_size,
        input   [1:0]         				io_arw_payload_burst,
        input   [1:0]         				io_arw_payload_lock,
        input                 				io_arw_payload_write,
        input   [7:0]         				io_w_payload_id,
        input                 				io_w_valid,
        output                				io_w_ready,
        input   [AXI_DBW-1:0]      			io_w_payload_data,
        input   [(AXI_DBW/8)-1:0]  			io_w_payload_strb,
        input                 				io_w_payload_last,
        output                				io_b_valid,
        input                 				io_b_ready,
        output  [7:0]         				io_b_payload_id,
        output                				io_r_valid,
        input                 				io_r_ready,
        output  [AXI_DBW-1:0]     			io_r_payload_data,
        output  [7:0] 		 			io_r_payload_id,
        output  [1:0]         				io_r_payload_resp,
        output                  			io_r_payload_last,
	output						hbc_cal_SHIFT_ENA,
	output	[2:0]					hbc_cal_SHIFT,
	output	[4:0]					hbc_cal_SHIFT_SEL,
	output  [15:0]					hbc_cal_debug_info,
     	output                        			hbc_rst_n,
     	output                        			hbc_cs_n,
     	output  [RAM_DBW/8-1:0]         		hbc_pcs_p_HI,
     	output  [RAM_DBW/8-1:0]         		hbc_pcs_p_LO,
     	output  [RAM_DBW/8-1:0]         		hbc_pcs_n_HI,
     	output  [RAM_DBW/8-1:0]         		hbc_pcs_n_LO,
     	output                        			hbc_ck_p_HI,
     	output                        			hbc_ck_p_LO,
     	output                        			hbc_ck_n_HI,
     	output                        			hbc_ck_n_LO,
     	output  [RAM_DBW/8-1:0]         		hbc_rwds_OUT_HI,
     	output  [RAM_DBW/8-1:0]         		hbc_rwds_OUT_LO,
     	input   [RAM_DBW/8-1:0]         		hbc_rwds_IN_HI,
     	input   [RAM_DBW/8-1:0]         		hbc_rwds_IN_LO,
     	output  [RAM_DBW/8-1:0]         		hbc_rwds_OE,
     	output  [RAM_DBW-1:0]           		hbc_dq_OUT_HI,
     	output  [RAM_DBW-1:0]           		hbc_dq_OUT_LO,
     	input   [RAM_DBW-1:0]           		hbc_dq_IN_HI,
     	input   [RAM_DBW-1:0]           		hbc_dq_IN_LO,
     	output  [RAM_DBW-1:0]           		hbc_dq_OE,
	output			        		hbc_cal_pass
);

/////////////////////////////////////////////////////////////////////////////
hbram_cal_axi_top #(
	.RAM_DBW		(RAM_DBW		),
	.RAM_ABW		(RAM_ABW		),
	.CFG_CR0		(CFG_CR0		),
	.CFG_CR1		(CFG_CR1		),
	.AXI_DBW		(AXI_DBW		),
	.AXI_AWR_DEPTH 		(AXI_AWR_DEPTH		),
	.AXI_W_DEPTH   		(AXI_W_DEPTH		),
	.AXI_R_DEPTH		(AXI_R_DEPTH		),
	.DQIN_MODE		(DQIN_MODE		),
	.RDO_DELAY      	(4			),	
	.CAL_CLK_CH		(CAL_CLK_CH		),
	.CAL_MODE		(2			),
	.CAL_DQ_STEPS		(8			),
	.CAL_RWDS_STEPS		(8			),
	.CAL_BYTES		('h100			),
	.TCYC			(TCYC			),
	.TCSM			(TCSM			),
	.TVCS			(TVCS			),
	.TRH			(TRH			),
	.TRTR			(TRTR			)
) hbram_cal_axi_top_inst (
	.rst			(rst			),
	.ram_clk              	(ram_clk   	    	), 
	.ram_clk_cal		(ram_clk_cal		),
	.io_axi_clk		(io_axi_clk		),
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
	.hbc_cal_SHIFT_ENA	(hbc_cal_SHIFT_ENA	),
	.hbc_cal_SHIFT_SEL	(hbc_cal_SHIFT_SEL	),
	.hbc_cal_SHIFT		(hbc_cal_SHIFT		),
	.hbc_cal_pass		(hbc_cal_pass		),
	.hbc_debug_info		(hbc_cal_debug_info	),
	.hbc_rst_n        	(hbc_rst_n              ), 
	.hbc_cs_n         	(hbc_cs_n               ),
	.hbc_pcs_p_HI     	(			),
	.hbc_pcs_p_LO     	(			),
	.hbc_pcs_n_HI     	(			),
	.hbc_pcs_n_LO     	(			),
	.hbc_ck_p_HI      	(hbc_ck_p_HI            ),
	.hbc_ck_p_LO      	(hbc_ck_p_LO            ),
	.hbc_ck_n_HI      	(hbc_ck_n_HI            ),
	.hbc_ck_n_LO      	(hbc_ck_n_LO            ),
	.hbc_rwds_OUT_HI  	(hbc_rwds_OUT_HI        ),
	.hbc_rwds_OUT_LO  	(hbc_rwds_OUT_LO        ),
	.hbc_rwds_IN_HI      	(hbc_rwds_IN_HI         ),
	.hbc_rwds_IN_LO      	(hbc_rwds_IN_LO         ),
	.hbc_rwds_OE      	(hbc_rwds_OE            ),
	.hbc_dq_OUT_HI    	(hbc_dq_OUT_HI          ),
	.hbc_dq_OUT_LO    	(hbc_dq_OUT_LO          ),
	.hbc_dq_IN_HI     	(hbc_dq_IN_HI	        ),
	.hbc_dq_IN_LO     	(hbc_dq_IN_LO	        ),
	.hbc_dq_OE        	(hbc_dq_OE              )
);
endmodule
