////////////////////////////////////////////////////////////////////////////
//           _____
//          / _______    Copyright (C) 2013-2021 Efinix Inc. All rights reserved.
//         / /       \
//        / /  ..    /   hbram_calibration_mst.v
//       / / .'     /
//    __/ /.'      /     Description:
//   __   \       /      hyper ram calibration logic coordinator
//  /_/ /\ \_____/ /
// ____/  \_______/
//
// ***********************************************************************
// Revisions:
// 1.0 Initial rev
//
// ***********************************************************************
module hbram_cal_mst
(
input			clk,
input			rst_n,
input			init_rdy,
output reg		cal_rstn,
output			cal_en,
input			cal_done,
input			cal_fail,
output			rdav_cal_inc,
output			rdav_cal_max,
output			mst_cal_done,
output			mst_cal_fail
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
nxH8awXDbobXaB6G1bD2N8x1oKwCO5OnGNWT5VbN860PYKXjRByidw6yCz/bMv/7
izUcBdgqDtVo6MeoAMQxrSP3MCvCS2B+azYjKJFg4jdyfBwrYGQtz9SEhGCjdxot
EWjEMoUOGy2IigcDmChMRBSJ/zKS+s7C+xkKu30+x20=
`pragma protect key_keyowner="Cadence Design Systems."
`pragma protect key_method="rsa"
`pragma protect key_keyname="CDS_RSA_KEY_VER_1"
`pragma protect encoding=(enctype="base64", line_length=64, bytes=256)
`pragma protect key_block
N1yr+fKH7CIRoNfYcekq/pykElMqSYOfS1hEQk0s5GUntkKvCeeRCq/O7oi6JzzX
3YyvajzdL4igjiYvDEC/kOApsn35Y5jty/4yjMikz1wA20SObsw2xPOQPcFR36BW
iRI8Xg9yF/AhVCnYRrMEbXKYV9fNEOoAFUzsa1cYo2TkdQsfLE8Opj0vhAweGwFs
iuWx51O/j06amfojRrToUNhSQSPyDDPpCCA4fQu7VdxBv+c7tv5KnSF9yNiN+Bry
0dQWIOPyURRVquqPt1Lx+Vh0X5lSlKyIIA56uP0oLcr6zhWaTgZ4IWgdenTJdCBX
HE1fiKREEdxQn5bGhWlYtg==
`pragma protect key_keyowner="Efinix Inc."
`pragma protect key_keyname="EFX_K01"
`pragma protect key_method="rsa"
`pragma protect encoding=(enctype="base64", line_length=64, bytes=256)
`pragma protect key_block
YFZiDYyhvM/pswZNLQ3jor4IKEBEseTzb2Op0kFu8qhMB8FR7QofRO3pIHqCCLto
Iky+7E7JK36A52eqIYe4oVXTz+K1h5OjV4njKVVXWocPOORiiivNbktjnnkAeQnB
zZkd9vAGSjbcA93XmPilEfPGjinh3/QkbtZJyLSW0mOisGjhmwc/i00WbOmvlqIT
5r/bf63wr3NgbtPevCPQjPKeGz72yPdNolganCYnEFOPL8rt2DkINtJRU6kfu+aI
GivgM7ksPJ6Z4iDfEJDUul87GiP/Idk+evvEk6oDfXYHVbOl7lJKZoFApY3cmABP
MND/Ucu4sDQ/ChCzhXkzDA==
`pragma protect encoding=(enctype="base64", line_length=64, bytes=2080)
`pragma protect data_block
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
YM8ZAcfq3FDS19ftUcUubA==
`pragma protect end_protected
