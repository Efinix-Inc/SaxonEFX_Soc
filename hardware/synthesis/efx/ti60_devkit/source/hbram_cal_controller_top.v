////////////////////////////////////////////////////////////////////////////
//           _____
//          / _______    Copyright (C) 2013-2021 Efinix Inc. All rights reserved.
//         / /       \
//        / /  ..    /   hbram_top.v
//       / / .'     /
//    __/ /.'      /     Description:
//   __   \       /      hyper ram controller top file
//  /_/ /\ \_____/ /
// ____/  \_______/
//
// ***********************************************************************
// Revisions:
// 1.0 Initial rev
//
// ***********************************************************************
`timescale 100ps/10ps
module hbram_cal_controller_top #(
parameter	 CAL_MODE	= 0,
parameter	 CAL_BYTES	= 'h100,
parameter 	 RAM_DBW	 = 8,
parameter 	 RAM_ABW	 = 25,
parameter 	 DQ_CAL_STEPS    = 8,
parameter 	 DQ_DLY_W	 = 3,
parameter 	 RWDS_CAL_STEPS  = 8,
parameter 	 RWDS_DLY_W 	 = 3,
parameter [15:0] CFG_CR0	 = 0,
parameter [15:0] CFG_CR1	 = 0,
parameter [47:0] CR0W_CA	 = 0,
parameter [47:0] CR1W_CA	 = 0,
parameter	 DQIN_MODE	 = "",
parameter	 RDO_DELAY	 = 4,
parameter	 TCYC		 = 10000,
parameter 	 TCSM		 = 4000000,
parameter	 TVCS		 = 150000000,
parameter	 TRH		 = 200000,
parameter	 TRTR		 = 40000
) (
input                              clk              , //system clock
input				clk_cal		 , //system clock for hard calibration
input                              rst_n            , //system reset
input                              h_rst_n          , //host reset psram
input				h_ctc		 ,
output				h_pause		 ,
output				h_cal_en	 ,
input                              h_req            , //start a new burst reqest, posedge edge dectection
input                              h_last           , //last word of current burst
input      [RAM_ABW-1:0]           h_addr           , //begin address of current burst request
input                              h_btype          , //burst type : 0-wapped burst1 1-inear burst
input                              h_atype          , //access space : 0-memory access 1-register acssss
input                              h_rwen           , //0: write 1: read
output reg                         h_mrdy           , //indicate to host, hyperbus ram initial completed,ready to access
input      [RAM_DBW/4-1:0]         h_wdm            , //write data mask
input      [RAM_DBW*2-1:0]         h_wdata          , //write data
output                             h_wrdy           , //indicate hyperbus is ready for write
output     [RAM_DBW*2-1:0]         h_rdata          , //burst read data to host
output                             h_rdav           , //read data avalid
output     [RWDS_DLY_W-1:0]        rwds_delay       , //automatic calibration read rwds phase select signal
output     [DQ_DLY_W*RAM_DBW-1:0]  dq_delay         ,
output	[15:0]			debug_info	 ,
//hyperbus sign als
output              	        hbc_rst_n        , //host reset to Hyperbus RAM
output              	        hbc_cs_n         , //psram chip select
output    [RAM_DBW/8-1:0]          hbc_pcs_p_HI     , //psram pcs positive HI signal to DDIO
output    [RAM_DBW/8-1:0]          hbc_pcs_p_LO     , //psram pcs positive LO signal to DDIO
output    [RAM_DBW/8-1:0]          hbc_pcs_n_HI     , //psram pcs negetive HI signal to DDIO
output    [RAM_DBW/8-1:0]          hbc_pcs_n_LO     , //psram pcs negetive LO signal to DDIO
output              	        hbc_ck_p_HI      , //psram ck positive HI signal to DDIO
output              	        hbc_ck_p_LO      , //psram ck positive LO signal to DDIO
output              	        hbc_ck_n_HI      , //psram ck negetive HI signal to DDIO
output              	        hbc_ck_n_LO      , //psram ck negetive LO signal to DDIO
output    [RAM_DBW/8-1:0]          hbc_rwds_OUT_HI  , //psram rwds output HI signal to DDIO
output    [RAM_DBW/8-1:0]          hbc_rwds_OUT_LO  , //psram rwds output LO signal to DDIO
input     [RAM_DBW/8-1:0]          hbc_rwds_IN_HI   , //psram rwds input signal from input IO
input     [RAM_DBW/8-1:0]          hbc_rwds_IN_LO   , //psram rwds input signal from input IO
input     [RAM_DBW/8-1:0]          hbc_rwds_IN_delay,
output    [RAM_DBW/8-1:0]          hbc_rwds_OE      , //psram rwds birdirectional output enable
output    [RAM_DBW-1:0]            hbc_dq_OUT_HI    , //psram DQ output HI signal to DDIO
output    [RAM_DBW-1:0]            hbc_dq_OUT_LO    , //psram DQ output LO signal to DDIO
input     [RAM_DBW-1:0]            hbc_dq_IN_HI     , //psram DQ input HI signal from DDIO
input     [RAM_DBW-1:0]            hbc_dq_IN_LO     , //psram DQ input LO signal from DDIO
output    [RAM_DBW-1:0]            hbc_dq_OE          //psram birdirectional output enable
);//pragma_insert
/* Encryption Envelope */
`pragma protect begin_protected
`pragma protect version=1
`pragma protect encrypt_agent="ipecrypt"
`pragma protect encrypt_agent_info="http://ipencrypter.com Version: 19.2.4"
`pragma protect data_method="aes256-cbc"
`pragma protect key_keyowner="Mentor Graphics Corporation"
`pragma protect key_method="rsa"
`pragma protect key_keyname="MGC-VERIF-SIM-RSA-1"
`pragma protect encoding=(enctype="base64", line_length=64, bytes=128)
`pragma protect key_block
JlldUfF2YquIzcVJ3HXyT4n40b9xUV1D3w7TEC+IKe3qB1FzaZUmjMVmZO2oOx7l
/MZvfZ8e4d1siBF8bzoQnKB/Is5MoEG7IfMUXmFu1u/9j+rlgVAUe/Ojtv1/6OBN
H/ZYsTR4f0rO4Xz1uXvPp1Lty97fRHNLr5uw0tNoIRg=
`pragma protect key_keyowner="Cadence Design Systems."
`pragma protect key_method="rsa"
`pragma protect key_keyname="CDS_RSA_KEY_VER_1"
`pragma protect encoding=(enctype="base64", line_length=64, bytes=256)
`pragma protect key_block
ntNdrdDjSCCs01ctGAwiVNEInojLoxD8P3Q2jCO5pZPJq4KltQm/6uc1hWMbCNjH
Mpa5STc4om7/XxcEIN50fhUSXkGHZ0M2GI4Lsb5ZtvtJgQbKZaZyzKiqTJCpigGx
D7iHaLMmCP51Qwkom++4w4Far2BoxPrtiElAb4cXEgqIT/V/0mcdCHN4w+14u4a6
wzHmiH2JPFdOpX9I9yLLBXSA4LuKxYB1wnkohGNB45H2nmtordxQyxLenYBUVf1e
mT36LHBFqOFSvEZC3bq70YuAbltrSplqYsIea69sgMQczP61esa115vviQViS/mF
YRxYGeOJ425mEOyO0BA1/A==
`pragma protect key_keyowner="Efinix Inc."
`pragma protect key_keyname="EFX_K01"
`pragma protect key_method="rsa"
`pragma protect encoding=(enctype="base64", line_length=64, bytes=256)
`pragma protect key_block
ghA09cSC9yHIYV6WGDSlY15H9BLtIhvnzFOX0li4Y5g+ObGx+cE0kDvfgwpInQGG
ZM2qKTUUIqDNnICOyIJMU9mVjwTm+t636+JPOdQ7OiIhR54OWwOD/eSzh+jdSGIX
mKkFpFM9FSlVPTS904djgmFV5Vuz6jJCnbj2dLSfh5gVr8ov2xrBpd7qyZUwKLph
cuqeewCCdB/TTzcXaK2zBO6suiZtdXvckO6TR19bnMp7t6aRMgKxOk7NfNsfNAHu
AKnxr8ucXaahGKDpHMZlPcJSG0wl2n/4keyfZArzzsdk8ziY0OicVbvo5L2ApLrQ
E+/euuRJvqm/F0EmHcqBsw==
`pragma protect encoding=(enctype="base64", line_length=64, bytes=4096)
`pragma protect data_block
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
6RkHvZBAtQvIas47rsbzmQ==
`pragma protect end_protected
