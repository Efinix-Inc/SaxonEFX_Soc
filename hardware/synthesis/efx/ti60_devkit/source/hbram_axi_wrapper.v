////////////////////////////////////////////////////////////////////////////
//           _____       
//          / _______    Copyright (C) 2013-2020 Efinix Inc. All rights reserved.
//         / /       \   
//        / /  ..    /   hbram_axi_wrapper.v
//       / / .'     /    
//    __/ /.'      /     Description:
//   __   \       /      Axi wrapper for hyper ram controller
//  /_/ /\ \_____/ /     
// ____/  \_______/      
//
// ***********************************************************************
// Revisions:
// 1.0 Initial rev
//
// ***********************************************************************
module hbram_axi_wrapper #(
	parameter RAM_DBW  	= 8,
	parameter RAM_ABW  	= 25,
	parameter AXI_DBW  	= 16,
	parameter AXI_AWR_DEPTH = 16,
	parameter AXI_W_DEPTH   = 256,
	parameter AXI_R_DEPTH	= 256
) (
	input				ram_clk,
	input				ram_rstn,
	input				io_axi_clk,
	input				io_axi_rstn,
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
        output  [7:0]		  	io_r_payload_id,
        output  [1:0]         		io_r_payload_resp,
        output                  	io_r_payload_last,
	input				h_pause,
	output				h_ctc,
     	output  reg                     h_req, 
     	output  reg                     h_last, 
     	output  reg [RAM_ABW-1:0]      	h_addr, 
     	output  reg                     h_btype, 
     	output  reg                     h_atype, 
     	output  reg                     h_rwen, 
     	input                         	h_mrdy, 
     	output  [RAM_DBW/4-1:0]        	h_wdm, 
     	output  [RAM_DBW*2-1:0]       	h_wdata, 
	input                         	h_wrdy, 
     	input   [RAM_DBW*2-1:0]       	h_rdata, 
     	input                         	h_rdav 
);

/////////////////////////////////////////////////////////////////////////////////
//Misc
localparam CONFIG_BIT		= RAM_ABW;
localparam AXI_STRBW		= AXI_DBW/8;
localparam C_RATIO		= AXI_DBW/(RAM_DBW*2);
//localparam SHIFT_ALIGN	= (AXI_DBW == 256) ? 5 :
//       			  (AXI_DBW == 128) ? 4 :
//			  	  (AXI_DBW == 64 ) ? 3 : 2;	  
localparam SHIFT_MUL		= (RAM_DBW == 16)? 2:
				  (RAM_DBW == 8) ? 1:0;

reg	[C_RATIO-1:0]		h_last_w;
reg				h_last_r;
reg				h_pause_strb;
reg	[11:0]			lenCnt;
reg	[1:0]			wrr_delay;
wire				op_rsp_sync;
wire				op_rdp_sync;
reg	[2:0]			w_state_sync;
reg	[2:0]			h_mrdy_sync;
reg	[2:0]			io_b_ready_sync;

//AWR Channel
localparam AWR_DEPTH 	  	= AXI_AWR_DEPTH;
localparam AWR_DATA_WIDTH 	= 54;
localparam AWR_PROG_FULL_ASSERT = AWR_DEPTH;
localparam AWR_PROG_FULL_NEGATE = AWR_DEPTH - 2;

wire	[AWR_DATA_WIDTH-1 :0]	awr_wdata;
wire	[AWR_DATA_WIDTH-1 :0]	awr_rdata;
wire				awr_rfifo;
wire				awr_wfifo;
wire				awr_rvalid;
wire				awr_rvalid_sync;
wire				awr_empty;
wire				awr_full;
reg	[RAM_ABW-1:0]		awr_aligned_bit;
reg 	[8:0]			i_len	= 'h0;
reg	[12:0]			i_len_c;	
reg	[8:0]			w_len	= 'h0;
reg	[8:0]			r_len	= 'h0;
reg	[7:0]			i_id	= 'h0;
reg	[2:0]			i_size	= 'h0;
reg	[AXI_DBW/8-1:0]		mask_strobe;
reg	[AXI_DBW-1:0]		mask_data;
reg	[AXI_DBW/8-1:0]		mask_strobe_sync;
reg	[AXI_DBW-1:0]		mask_data_sync;
reg				config_sync;
wire	[AXI_DBW-1:0]		w_config_data;
wire	[AXI_DBW-1:0]		r_config_data;
wire	[AXI_DBW/8-1:0]		w_config_strb;
wire	[AXI_DBW-1:0]		w_payload_data;
wire	[AXI_DBW/8-1:0]		w_payload_strb;

//W Channel
localparam W_DEPTH 	  	= AXI_W_DEPTH  ;
localparam W_DATA_WIDTH 	= AXI_DBW + AXI_STRBW + 1;
localparam W_PROG_FULL_ASSERT   = W_DEPTH;
localparam W_PROG_FULL_NEGATE   = W_DEPTH - 2;
localparam W_OUTPUT_REG		= (C_RATIO == 1) ? 0 : 1;

reg				w_pause_flag;
reg	[8:0]			i_wlen_c;
reg	[7:0]			i_wid_c;
wire	[W_DATA_WIDTH-1:0]	w_wdata;
wire	[$clog2(W_DEPTH)-1:0]	w_wdata_cnt;
wire	[$clog2(W_DEPTH)-1:0]	w_rdata_cnt;
reg	[AXI_DBW-1:0]		w_wdata_shift;
reg	[AXI_DBW/8-1:0]		w_wstrb_shift;
wire	[W_DATA_WIDTH-1:0]	w_rdata;
wire				w_empty;
wire				w_full;
wire				w_wfifo;
wire				w_rvalid;
wire				w_rfifo;
wire				w_rfifo_pre;
reg	[7:0]			w_rfifo_cnt;
wire				w_rfifo_valid;
reg				w_rfifo_validr;
//R Channel
localparam R_DEPTH 	  	= AXI_R_DEPTH ;
localparam R_DATA_WIDTH 	= AXI_DBW + 1;
localparam R_PROG_FULL_ASSERT 	= R_DEPTH;
localparam R_PROG_FULL_NEGATE 	= R_DEPTH - 2;

wire	[R_DATA_WIDTH-1:0]	r_wdata;
wire	[R_DATA_WIDTH-1:0]	r_rdata;
wire				r_empty;
wire				r_full;
wire				r_wfifo;
wire				r_rvalid;
wire				r_rfifo;
wire				cntLast;
reg				rvalid_act = 'h0;
reg	[7:0]			r_id	   = 'h0;
reg				r_rdav	   = 'b0;
wire				p_rdav;
wire 				r_wfifo_pre;
reg [AXI_DBW-1:0] 		r_wdata_shift;
reg 				r_wfifo_reg;

//State machine
localparam [3:0] IDLE		='h0,
		 REQ		='h1,
		 OPR		='h2,
		 WRITE_R	='h3,
		 WRITE		='h4,
		 RSP		='h5,
		 READ		='h6,
		 READ_P		='h7,
		 READ_C		='h8;

reg	[3:0]			state_ps, 
				state_ns;
wire				op_wr, 
				op_wrr,
				op_rd, 
				op_rdp, 
				op_rsp;
/////////////////////////////////////////////////////////////////////////////////
//io_axi_clk 

pulse_synchronizer awr_sync
(
        .clk_i		(ram_clk	),
        .pulse_i	(awr_rvalid	),
        .clk_o		(io_axi_clk	),
        .pulse_o	(awr_rvalid_sync)

);

always@(posedge io_axi_clk)
begin
	h_mrdy_sync[2] <= h_mrdy;
	h_mrdy_sync[1] <= h_mrdy_sync[2];
	h_mrdy_sync[0] <= h_mrdy_sync[1];
end

always@(posedge io_axi_clk)
begin
	w_state_sync[2] <= op_wrr ;
	w_state_sync[1] <= w_state_sync[2];
	w_state_sync[0] <= w_state_sync[1];
end


assign w_payload_data   = (config_sync ? w_config_data : io_w_payload_data) & mask_data_sync;
assign w_payload_strb   = (config_sync ? w_config_strb : io_w_payload_strb) & mask_strobe_sync;

assign w_wdata		= {io_w_payload_last,w_payload_strb,w_payload_data};
assign w_wfifo		= io_w_ready & io_w_valid;
assign io_w_ready  	= h_mrdy_sync[0] & w_state_sync[0] & !(w_wdata_cnt >= i_wlen_c);

always@(posedge io_axi_clk)
begin
	if(awr_rvalid_sync)
		begin
		i_wlen_c         <= i_len;
		mask_data_sync   <= mask_data;
		mask_strobe_sync <= mask_strobe;
		config_sync      <= h_atype;
		end
	else 
		begin
		i_wlen_c         <= i_wlen_c;
		mask_data_sync   <= mask_data_sync;
		mask_strobe_sync <= mask_strobe_sync;
		config_sync	 <= config_sync;
		end
end 

generate if(RAM_DBW == 8)
begin
	assign w_config_data	= {AXI_DBW/(RAM_DBW*2){io_w_payload_data[15:0]}};
	assign w_config_strb	= { {AXI_STRBW-2{1'b0}}, {2{1'b1}} };
	assign r_config_data	= { {AXI_DBW-16{1'b0}}, r_rdata[15:0] };
end
else
begin
	assign w_config_data	= {AXI_DBW/(RAM_DBW*2){8'h0,io_w_payload_data[15:8],8'h0,io_w_payload_data[7:0]}};
	assign w_config_strb	= { {AXI_STRBW-4{1'b0}}, {4{1'b1}} };
	assign r_config_data	= { {AXI_DBW-16{1'b0}}, r_rdata[23:16], r_rdata[7:0] };

end
endgenerate

always@(posedge io_axi_clk)
begin
	if(w_wfifo && io_w_payload_last)
		i_wid_c <= io_w_payload_id;
	else
		i_wid_c <= i_wid_c;
end

//ram_clk
always@ (posedge ram_clk)
begin
	if(i_len == 'd256)
		w_len <= i_len - 1 ;
       	else
       		w_len <= i_len;
end	

assign w_rfifo_valid = op_wr & h_wrdy;

always@(posedge ram_clk or negedge ram_rstn)
begin
	if(!ram_rstn)
		w_rfifo_cnt <= 'h0;
	else begin
		if(w_rfifo)
			w_rfifo_cnt <= 'h0;	
		else if(w_rfifo_valid)
			w_rfifo_cnt <= w_rfifo_cnt + 1'b1;
		else				
			w_rfifo_cnt <= w_rfifo_cnt;
	end
end

always@ (posedge ram_clk)
begin
	//if(h_pause || h_pause_strb)
	if(h_pause)
		w_pause_flag <= 1'b1;
	else if (w_rfifo || r_wfifo)
		w_pause_flag <= 1'b0;
	else
		w_pause_flag <= w_pause_flag;
end

//assign h_ctc = w_pause_flag & ((w_rfifo_cnt[3:0] == C_RATIO-(1+w_strb_cnt)) | r_wfifo);
assign h_ctc = w_pause_flag & ((w_rfifo_cnt[3:0] == C_RATIO-1) | r_wfifo);

generate
if(C_RATIO == 1) begin
	assign w_rfifo  = w_rfifo_valid; 
end
else begin
	assign w_rfifo  = (((w_rfifo_cnt[3:0] == C_RATIO-1) && !w_pause_flag) || w_rfifo_pre );
end

endgenerate

always@ (posedge ram_clk) w_rfifo_validr <= w_rfifo_valid; 
assign w_rfifo_pre = w_rfifo_valid & ~w_rfifo_validr;


always@ (posedge ram_clk)
begin
	case(C_RATIO)
	1: begin
		if(w_rfifo) begin
			w_wstrb_shift  <= ~(w_rdata[AXI_DBW +: AXI_STRBW]);
			w_wdata_shift  <= w_rdata[AXI_DBW-1:0];
		end
		else begin
			w_wstrb_shift  <= w_wstrb_shift;
			w_wdata_shift  <= w_wdata_shift;
		end
	end
	default: begin	
		if(w_rfifo) begin
			w_wstrb_shift	<= ~(w_rdata[AXI_DBW +: AXI_STRBW]);
			w_wdata_shift   <= w_rdata[AXI_DBW-1:0];
		end
		else begin
			w_wstrb_shift  <= w_wstrb_shift >> (RAM_DBW/4);
			w_wdata_shift  <= w_wdata_shift >> (RAM_DBW*2);
		end
	end
	endcase
end

assign h_wdm    =  w_rfifo_valid ? w_wstrb_shift[RAM_DBW/4-1:0] : {RAM_DBW{1'b1}};
assign h_wdata  =  w_wdata_shift[RAM_DBW*2-1:0] ;

efx_fifo_wrapper #(
        .OPTIONAL_FLAGS         ( 1 ),
        .SYNC_CLK               ( 0 ),
        .DEPTH                  ( W_DEPTH ),
        .DATA_WIDTH             ( W_DATA_WIDTH ),
        .MODE                   ( "FWFT" ),
        .OUTPUT_REG             ( W_OUTPUT_REG ),
        .PROG_FULL_ASSERT       ( W_PROG_FULL_ASSERT ),
        .PIPELINE_REG           ( 1 ),
        .PROG_FULL_NEGATE       ( W_PROG_FULL_NEGATE ),
        .PROG_EMPTY_ASSERT      ( 0 ),
        .PROG_EMPTY_NEGATE      ( 0 ),
        .PROGRAMMABLE_FULL      ( "STATIC_SINGLE" ),
        .PROGRAMMABLE_EMPTY     ( "STATIC_SINGLE" )
) fifo_w_inst (

    .almost_full_o	(		),
    .prog_full_o	(		),
    .full_o		(w_full		),
    .overflow_o		(		),
    .wr_ack_o		(		),
    .empty_o		(w_empty	),
    .almost_empty_o	(		),
    .prog_empty_o	(		),
    .underflow_o	(		),
    .rd_valid_o		(w_rvalid	),
    //.wr_adr_o		(		),
    //.rd_adr_o		(		),
    .rdata		(w_rdata	),
    .clk_i		(		),
    .wr_clk_i		(io_axi_clk	),
    .rd_clk_i		(ram_clk	),
    .wr_en_i		(w_wfifo	),
    .rd_en_i		(w_rfifo	),
    .a_rst_i		(~io_axi_rstn	),
    .wdata		(w_wdata	),
    .datacount_o	(		),
    .wr_datacount_o	(w_wdata_cnt	),
    .rd_datacount_o	(w_rdata_cnt    )
);

/////////////////////////////////////////////////////////////////////////////////
//AWR Channel
//io_axi_clk
assign awr_wfifo	= io_arw_ready && io_arw_valid;
assign awr_wdata  	= {io_arw_payload_id, io_arw_payload_len, io_arw_payload_size, 
			io_arw_payload_burst, io_arw_payload_write, io_arw_payload_addr};
assign io_arw_ready 	= h_mrdy_sync[0] & !awr_full;
//ram_clk
assign awr_rfifo 	= (state_ps == REQ);

efx_fifo_wrapper #(
        .OPTIONAL_FLAGS 	( 1 ),
        .SYNC_CLK 		( 0 ),
        .DEPTH 			( AWR_DEPTH ),
        .DATA_WIDTH 		( AWR_DATA_WIDTH ),
        .MODE 			( "STANDARD" ),
        .OUTPUT_REG 		( 1 ),
        .PROG_FULL_ASSERT 	( AWR_PROG_FULL_ASSERT ),
        .PIPELINE_REG 		( 1 ),
        .PROG_FULL_NEGATE 	( AWR_PROG_FULL_NEGATE ),
        .PROG_EMPTY_ASSERT 	( 0 ),
        .PROG_EMPTY_NEGATE 	( 0 ),
        .PROGRAMMABLE_FULL 	( "STATIC_SINGLE" ),
        .PROGRAMMABLE_EMPTY 	( "STATIC_SINGLE" )
) fifo_awr_inst (
    .almost_full_o	(		),
    .prog_full_o	(		),
    .full_o		(awr_full	),
    .overflow_o		(		),
    .wr_ack_o		(		),
    .empty_o		(awr_empty	),
    .almost_empty_o	(		),
    .prog_empty_o	(		),
    .underflow_o	(		),
    //.wr_adr_o		(		),
    //.rd_adr_o		(		),
    .rd_valid_o		(awr_rvalid	),
    .rdata		(awr_rdata	),
    .clk_i		(		),
    .wr_clk_i		(io_axi_clk	),
    .rd_clk_i		(ram_clk	),
    .wr_en_i		(awr_wfifo	),
    .rd_en_i		(awr_rfifo	),
    .a_rst_i		(~io_axi_rstn	),
    .wdata		(awr_wdata	),
    .datacount_o	(		),
    .wr_datacount_o	(		),
    .rd_datacount_o	(		)
);

/////////////////////////////////////////////////////////////////////////////////
//B Channel
pulse_synchronizer B_sync
(
        .clk_i		(ram_clk),
        .pulse_i	(op_rsp),
        .clk_o		(io_axi_clk),
        .pulse_o	(op_rsp_sync)

);

assign io_b_valid = op_rsp_sync;
assign io_b_payload_id = i_wid_c;

/////////////////////////////////////////////////////////////////////////////////
//R Channel
//ramram_clk

reg r_wfifo_post;
wire r_wfifo_last;

assign r_wfifo_pre = (h_rdav & h_mrdy & op_rd) && !(lenCnt >= i_len_c);

always @(posedge ram_clk) r_wfifo_post <= r_wfifo_pre;
assign r_wfifo_last = (r_wfifo_post & ~r_wfifo_pre  && lenCnt != 'h0);


generate
if (C_RATIO == 1)
begin
	always@ (posedge ram_clk)
	begin
		if(r_wfifo_pre)
			r_wdata_shift <= h_rdata;
		else
			r_wdata_shift <= r_wdata_shift;
	end
end
else begin
	always@ (posedge ram_clk)
	begin
		if(r_wfifo_pre)
			r_wdata_shift <= {h_rdata, r_wdata_shift[AXI_DBW-1 -: AXI_DBW-(RAM_DBW*2)]};
		else if (r_wfifo_last)
			r_wdata_shift <= r_wdata_shift << RAM_DBW*2;
		else
			r_wdata_shift <= r_wdata_shift;
	end
end
endgenerate

assign r_wdata = {h_last , r_wdata_shift};

generate 
case(C_RATIO)
	2 : always@ (posedge ram_clk) begin  r_wfifo_reg <= (lenCnt[0]   == 'd1) & r_wfifo_pre; end
	4 : always@ (posedge ram_clk) begin  r_wfifo_reg <= (lenCnt[1:0] == 'd3) & r_wfifo_pre; end
	8 : always@ (posedge ram_clk) begin  r_wfifo_reg <= (lenCnt[2:0] == 'd7) & r_wfifo_pre; end
	16: always@ (posedge ram_clk) begin  r_wfifo_reg <= (lenCnt[3:0] == 'd15) & r_wfifo_pre; end
	default: 
	   always@ (posedge ram_clk) begin  r_wfifo_reg <= r_wfifo_pre; end 
endcase
endgenerate
	
assign r_wfifo = r_wfifo_reg ;

efx_fifo_wrapper #(
        .OPTIONAL_FLAGS 	( 1 ),
        .SYNC_CLK 		( 0 ),
        .DEPTH 			( R_DEPTH ),
        .DATA_WIDTH 		( R_DATA_WIDTH ),
        .MODE 			( "FWFT" ),
        .OUTPUT_REG 		( 0 ),
        .PROG_FULL_ASSERT 	( R_PROG_FULL_ASSERT ),
        .PIPELINE_REG 		( 1 ),
        .PROG_FULL_NEGATE 	( R_PROG_FULL_NEGATE ),
        .PROG_EMPTY_ASSERT 	( 0 ),
        .PROG_EMPTY_NEGATE 	( 0 ),
        .PROGRAMMABLE_FULL 	( "STATIC_SINGLE" ),
        .PROGRAMMABLE_EMPTY 	( "STATIC_SINGLE" )

) fifo_r_inst (
    .almost_full_o	(		),
    .prog_full_o	(		),
    .full_o		(r_full		),
    .overflow_o		(		),
    .wr_ack_o		(		),
    .empty_o		(r_empty	),
    .almost_empty_o	(		),
    .prog_empty_o	(		),
    .underflow_o	(		),
    //.wr_adr_o		(		),
    //.rd_adr_o		(		),
    .rd_valid_o		(r_rvalid	),
    .rdata		(r_rdata	),
    .clk_i		(		),
    .wr_clk_i		(ram_clk	),
    .rd_clk_i		(io_axi_clk	),
    .wr_en_i		(r_wfifo	),
    .rd_en_i		(r_rfifo	),
    .a_rst_i		(~io_axi_rstn	),
    .wdata		(r_wdata	),
    .datacount_o	(		),
    .wr_datacount_o	(		),
    .rd_datacount_o	(		)
);

generate 
if(C_RATIO > 1)
begin
	always@ (posedge ram_clk)
	begin
		h_last_w[0]   <= op_wr ? w_rdata[W_DATA_WIDTH-1] & h_wrdy & w_rfifo : 'b0;
		h_last_w[C_RATIO-1:1] <= op_wr ? h_last_w[C_RATIO-2:0] : 'h0;	
	end
end
else
begin
	always@ (posedge ram_clk)
	begin
		h_last_w[0]   <= op_wr ? w_rdata[W_DATA_WIDTH-1] & h_wrdy & w_rfifo : 'b0;
	end
end
endgenerate

always@ (posedge ram_clk)
begin
	h_last_r <=  op_rd? cntLast & h_rdav : 'b0;
end

always@ (*)
begin
	h_last <=  h_last_w[C_RATIO-1] | h_last_r;
end

always@ (posedge ram_clk or negedge ram_rstn)
begin
	if(!ram_rstn)
		lenCnt <= 'h0;
	else begin
		if(cntLast)
			lenCnt <= 'h0;
		else if(r_wfifo_pre)
			lenCnt <= lenCnt + 1;
		else if(r_wfifo_last)
			lenCnt <= lenCnt - 1;
		else
			lenCnt <= lenCnt;
	end
end

wire act_complete;
wire act_complete_sync;

assign act_complete = io_r_payload_last && io_r_ready;

//compensate register 1 clock
assign cntLast = (lenCnt == i_len_c - 1);

assign  r_rfifo = io_r_ready && r_rvalid && rvalid_act;

always@ (posedge io_axi_clk)
begin
	if(op_rdp_sync)
		rvalid_act <= 1'b1;
	else if(io_r_payload_last && io_r_ready )
		rvalid_act <= 1'b0;
	else
		rvalid_act <= rvalid_act;
end

always@ (posedge io_axi_clk)
begin
	if(op_rdp_sync)
	begin
		r_id  <= i_id;
		r_len <= i_len;
	end	
	else 
	begin
		r_id  <= r_id;
		r_len <= r_len;
	end
end

pulse_synchronizer rdp_sync
(
        .clk_i		(ram_clk),
        .pulse_i	(op_rdp),
        .clk_o		(io_axi_clk),
        .pulse_o	(op_rdp_sync)

);

pulse_synchronizer rdc_sync
(
        .clk_i		(io_axi_clk),
        .pulse_i	(act_complete),
        .clk_o		(ram_clk),
        .pulse_o	(act_complete_sync)

);

assign io_r_valid 		= r_rvalid & rvalid_act;
assign io_r_payload_data 	= (config_sync ? r_config_data : r_rdata[AXI_DBW-1:0] ) & mask_data_sync;
assign io_r_payload_id 		= r_id;
assign io_r_payload_resp 	= 'h0;
assign io_r_payload_last 	= io_r_valid ? r_rdata[R_DATA_WIDTH-1] : 1'b0;

/////////////////////////////////////////////////////////////////////////////////
//MISC
assign op_wr  = (state_ps == WRITE);
assign op_wrr = (state_ps == WRITE_R);
assign op_rd  = (state_ps == READ);
assign op_rdp = (state_ps == READ_P);
assign op_rsp = (state_ps == RSP);

//RAM interface assign

always@ (posedge ram_clk)
begin
	h_req <= op_wr | op_rd;
end

always@ (posedge ram_clk)
begin
	if(awr_rvalid)
	begin
		h_addr  <= awr_rdata[CONFIG_BIT] ? awr_rdata[RAM_ABW-1:0] : 
			((awr_rdata[RAM_ABW-1:0] & ~awr_aligned_bit)  >> SHIFT_MUL); 
		h_atype <= awr_rdata[CONFIG_BIT];
		h_rwen  <= ~awr_rdata[32];
		h_btype <= (awr_rdata[34:33] != 'b10);
		i_size 	<= awr_rdata[37:35];
		i_len	<= (awr_rdata[45:38] + 1'b1); 
		i_id	<= awr_rdata[53:46];	
	end else 
	begin
		h_addr  <= h_addr; 
		h_atype <= h_atype;
		h_btype <= h_btype;
		h_rwen  <= h_rwen;
		i_size 	<= i_size;
		i_len	<= i_len;
		i_id	<= i_id;
	end
end

generate

case(C_RATIO)
	2 :always@ (*) begin i_len_c <= i_len << 1; end
	4 :always@ (*) begin i_len_c <= i_len << 2; end
	8 :always@ (*) begin i_len_c <= i_len << 3; end
	16:always@ (*) begin i_len_c <= i_len << 4; end
	default:
	  always@ (*) begin i_len_c <= i_len; end
endcase

if(AXI_DBW == 256)
begin
	always@ (*)
	begin
	case(i_size)
	3'b000: mask_strobe  <= { {AXI_STRBW-1 {1'b0}} , {1{1'b1} }};
	3'b001: mask_strobe  <= { {AXI_STRBW-2 {1'b0}} , {2{1'b1} }};
	3'b010: mask_strobe  <= { {AXI_STRBW-4 {1'b0}} , {4{1'b1} }};
	3'b011: mask_strobe  <= { {AXI_STRBW-8 {1'b0}} , {8{1'b1} }};
	3'b100: mask_strobe  <= { {AXI_STRBW-16{1'b0}} , {16{1'b1}}};
	3'b101: mask_strobe  <= { AXI_STRBW{1'b1} };
	default: mask_strobe <= { AXI_STRBW{1'b1} };
	endcase	
	end

	always@ (*)
	begin
	case(i_size)
	3'b000: mask_data  <= { {AXI_DBW-8{1'b0}}  , {8{1'b1}   }};
	3'b001: mask_data  <= { {AXI_DBW-16{1'b0}} , {16{1'b1}  }};
	3'b010: mask_data  <= { {AXI_DBW-32{1'b0}} , {32{1'b1}  }};
	3'b011: mask_data  <= { {AXI_DBW-64{1'b0}} , {64{1'b1}  }};
	3'b100: mask_data  <= { {AXI_DBW-128{1'b0}}, {128{1'b1} }} ;
	3'b101: mask_data  <= { AXI_DBW{1'b1} };
	default: mask_data <= { AXI_DBW{1'b1} };
	endcase
	end

	always@ (*)
	begin
	case(i_size)
	3'b000: awr_aligned_bit <= 'h0;
	3'b001: awr_aligned_bit <= 'h1;
	3'b010: awr_aligned_bit <= 'h3;
	3'b011: awr_aligned_bit <= 'h7;
	3'b100: awr_aligned_bit <= 'hF;
	3'b101: awr_aligned_bit <= 'h1F;
	default : awr_aligned_bit <= 'h1F;
	endcase
	end

end
else if(AXI_DBW == 128)
begin
	always@ (*)
	begin
	case(i_size)
	3'b000: mask_strobe  <= { {AXI_STRBW-1{1'b0}} , {1{1'b1} }};
	3'b001: mask_strobe  <= { {AXI_STRBW-2{1'b0}} , {2{1'b1} }};
	3'b010: mask_strobe  <= { {AXI_STRBW-4{1'b0}} , {4{1'b1} }};
	3'b011: mask_strobe  <= { {AXI_STRBW-8{1'b0}} , {8{1'b1} }};
	3'b100: mask_strobe  <= { AXI_STRBW{1'b1} };
	default: mask_strobe <= { AXI_STRBW{1'b1} };
	endcase	
	end

	always@ (*)
	begin
	case(i_size)
	3'b000: mask_data  <= { {AXI_DBW-8{1'b0}}  , {8{1'b1} }};
	3'b001: mask_data  <= { {AXI_DBW-16{1'b0}} , {16{1'b1} }};
	3'b010: mask_data  <= { {AXI_DBW-32{1'b0}} , {32{1'b1} }};
	3'b011: mask_data  <= { {AXI_DBW-64{1'b0}} , {64{1'b1} }};
	3'b100: mask_data  <= { AXI_DBW{1'b1}  };
	default: mask_data <= { AXI_DBW{1'b1} };
	endcase
	end

	always@ (*)
	begin
	case(i_size)
	3'b000: awr_aligned_bit <= 'h0;
	3'b001: awr_aligned_bit <= 'h1;
	3'b010: awr_aligned_bit <= 'h3;
	3'b011: awr_aligned_bit <= 'h7;
	3'b100: awr_aligned_bit <= 'hF;
	default : awr_aligned_bit <= 'hF;
	endcase
	end

end
else if(AXI_DBW == 64)
begin
	always@ (*)
	begin
	case(i_size)
	3'b000: mask_strobe  <= { {AXI_STRBW-1{1'b0}} , {1{1'b1} }};
	3'b001: mask_strobe  <= { {AXI_STRBW-2{1'b0}} , {2{1'b1} }};
	3'b010: mask_strobe  <= { {AXI_STRBW-4{1'b0}} , {4{1'b1} }};
	3'b011: mask_strobe  <= { AXI_STRBW{1'b1} };
	default: mask_strobe <= { AXI_STRBW{1'b1} };
	endcase	
	end

	always@ (*)
	begin
	case(i_size)
	3'b000: mask_data  <= { {AXI_DBW-8{1'b0}}  , {8{1'b1} }};
	3'b001: mask_data  <= { {AXI_DBW-16{1'b0}} , {16{1'b1} }};
	3'b010: mask_data  <= { {AXI_DBW-32{1'b0}} , {32{1'b1} }};
	3'b011: mask_data  <= { AXI_DBW{1'b1}  };
	default: mask_data <= { AXI_DBW{1'b1} };
	endcase
	end

	always@ (*)
	begin
	case(i_size)
	3'b000: awr_aligned_bit <= 'h0;
	3'b001: awr_aligned_bit <= 'h1;
	3'b010: awr_aligned_bit <= 'h3;
	3'b011: awr_aligned_bit <= 'h7;
	default : awr_aligned_bit <= 'h7;
	endcase
	end

end
else
begin
	always@ (*)
	begin
	case(i_size)
	3'b000: mask_strobe  <= { {AXI_STRBW-1{1'b0}} , {1{1'b1} }};
	3'b001: mask_strobe  <= { {AXI_STRBW-2{1'b0}} , {2{1'b1} }};
	3'b010: mask_strobe  <= { AXI_STRBW{1'b1} };
	default: mask_strobe <= { AXI_STRBW{1'b1} };
	endcase	
	end

	always@ (*)
	begin
	case(i_size)
	3'b000: mask_data  <= { {AXI_DBW-8{1'b0}}  , {8{1'b1} }};
	3'b001: mask_data  <= { {AXI_DBW-16{1'b0}} , {16{1'b1} }};
	3'b010: mask_data  <= { AXI_DBW{1'b1}  };
	default: mask_data <= { AXI_DBW{1'b1} };
	endcase
	end

	always@ (*)
	begin
	case(i_size)
	3'b000: awr_aligned_bit <= 'h0;
	3'b001: awr_aligned_bit <= 'h1;
	3'b010: awr_aligned_bit <= 'h3;
	default : awr_aligned_bit <= 'd3;
	endcase
	end

end
endgenerate
/////////////////////////////////////////////////////////////////////////////////

always@(posedge ram_clk or negedge ram_rstn)
begin
	if(!ram_rstn)
		wrr_delay <= 'h0;
	else begin
		if(op_wrr)
			wrr_delay <= {wrr_delay[0], 1'b1};
		else
			wrr_delay <= 'h0;
	end
end

always@ (posedge ram_clk)
begin
	io_b_ready_sync[2] <= io_b_ready;
	io_b_ready_sync[1] <= io_b_ready_sync[2];
	io_b_ready_sync[0] <= io_b_ready_sync[1];
end

always@ (posedge ram_clk or negedge ram_rstn)
begin	
	if(!ram_rstn)
		state_ps <= IDLE;
	else
		state_ps <= state_ns;
end

always@ (*)
begin
	state_ns = state_ps;
	case(state_ps)
	IDLE:
	begin
		if(!awr_empty)
			state_ns = REQ;
		else
			state_ns = IDLE;
	end
	REQ: state_ns = OPR;
	OPR:
	begin
		if(awr_rvalid && awr_rdata[32])
			state_ns = WRITE_R;
		else if (awr_rvalid && !awr_rdata[32])
			state_ns = READ;
		else
			state_ns = OPR;
	end
	WRITE_R:
	begin
		if(wrr_delay[1] && w_rdata_cnt >= w_len )
			state_ns = WRITE;
	        else
			state_ns = WRITE_R;	
	end
	WRITE:
	begin
		//if(w_rdata[W_DATA_WIDTH-1] && h_wrdy)
		if(h_last_w[C_RATIO-1] && h_wrdy)
			state_ns = RSP;
		else
			state_ns = WRITE;
	end
	RSP:
	begin
		if(io_b_ready_sync[0])
			state_ns = IDLE;
		else
			state_ns = RSP;
	end
	READ:
	begin
		if(cntLast && h_rdav)
			state_ns = READ_P;
		else
			state_ns = READ;
	end
	READ_P : state_ns = READ_C;
	READ_C : 
	begin
		if(act_complete_sync)
			state_ns = IDLE;
		else
			state_ns = READ_C;
	end
	default: state_ns = IDLE;
	endcase
end

endmodule
