////////////////////////////////////////////////////////////////////////////
//           _____
//          / _______    Copyright (C) 2013-2021 Efinix Inc. All rights reserved.
//         / /       \
//        / /  ..    /   hbram_controller.v
//       / / .'     /
//    __/ /.'      /     Description:
//   __   \       /      hyper ram controller
//  /_/ /\ \_____/ /
// ____/  \_______/
//
// ***********************************************************************
// Revisions:
// 1.0 Initial rev
//
// ***********************************************************************
`timescale 100ps/10ps
module hbram_cal_ctrl #(
parameter	 CAL_MODE	= 0,
parameter        RAM_DBW	= 8,
parameter        RAM_ABW	= 25,
parameter [15:0] CFG_CR0	= 0,
parameter [15:0] CFG_CR1	= 0,
parameter [47:0] CR0W_CA	= 0,
parameter [47:0] CR1W_CA	= 0,
parameter	 DQIN_MODE	= "",
parameter	 RDO_DELAY	= 4,
parameter	 TCYC		= 10000,
parameter 	 TCSM		= 4000000,
parameter	 TVCS		= 150000000,
parameter	 TRH		= 200000,
parameter	 TRTR		= 40000
) (
input                          clk               , //system clock
input			    clk_cal	      ,
input                          rst_n             , //system reset
input                          h_rst_n           , //host reset psram
input                          h_req             , //start a new burst reqest, posedge edge dectection
input                          h_last            , //last word of current burst
input      [RAM_ABW-1:0]       h_addr            , //begin address of current burst request
input                          h_btype           , //burst type : 0-wapped burst1 1-inear burst
input                          h_atype           , //access space : 0-memory access 1-register acssss
input                          h_rwen            , //0: write 1: read
output                         h_mrdy            , //indicate to host, hyperbus ram initial completed,ready to access
input      [RAM_DBW/4-1:0]     h_wdm             , //write data mask
input      [RAM_DBW*2-1:0]     h_wdata           , //write data
output                         h_wrdy            , //indicate hyperbus is ready for write
output     [RAM_DBW*2-1:0]     h_rdata           , //burst read data to host
output                         h_rdav            , //read data avalid
output			    h_pause	      , //temporarily pause the transfer
input			    h_ctc	      , //flag to safely stop/pause the transfer
input                          cal_req           , //auto calibration burst request
input                          cal_last          , //last word of auto calibration burst
input                          cal_done          , //callibration successfully be done
input      [RAM_ABW-1:0]       cal_addr          , //begin address of calibration burst
input                          cal_rwen          , //0:write 1:read
input      [RAM_DBW*2-1:0]     cal_wdata         , //auto calibration initial write data
output                         cal_wrdy          , //auto calibration initial write ready
output     [RAM_DBW*2-1:0]     cal_rdata         , //auto calibration read data
output                         cal_rdav          , //auto calibration read data valid
input			    rdav_cal_inc      ,
output		            rdav_cal_max      ,
output                         hbc_rst_n         , //host reset to Hyperbus RAM
output reg          	    hbc_cs_n          , //psram chip select
output reg [RAM_DBW/8-1:0]     hbc_pcs_p_HI      , //psram pcs positive HI signal to DDIO
output reg [RAM_DBW/8-1:0]     hbc_pcs_p_LO      , //psram pcs positive LO signal to DDIO
output reg [RAM_DBW/8-1:0]     hbc_pcs_n_HI      , //psram pcs negetive HI signal to DDIO
output reg [RAM_DBW/8-1:0]     hbc_pcs_n_LO      , //psram pcs negetive LO signal to DDIO
output reg          	    hbc_ck_p_HI       , //psram ck positive HI signal to DDIO
output reg          	    hbc_ck_p_LO       , //psram ck positive LO signal to DDIO
output reg          	    hbc_ck_n_HI       , //psram ck negetive HI signal to DDIO
output reg          	    hbc_ck_n_LO       , //psram ck negetive LO signal to DDIO
output reg [RAM_DBW/8-1:0]     hbc_rwds_OUT_HI   , //psram rwds output HI signal to DDIO
output reg [RAM_DBW/8-1:0]     hbc_rwds_OUT_LO   , //psram rwds output LO signal to DDIO
input      [RAM_DBW/8-1:0]     hbc_rwds_IN_HI       , //psram rwds input signal from input IO
input      [RAM_DBW/8-1:0]     hbc_rwds_IN_LO       , //psram rwds input signal from input IO
input      [RAM_DBW/8-1:0]     hbc_rwds_IN_delay ,
output reg [RAM_DBW/8-1:0]     hbc_rwds_OE       , //psram rwds birdirectional output enable
output reg [RAM_DBW-1:0]       hbc_dq_OUT_HI     , //psram DQ output HI signal to DDIO
output reg [RAM_DBW-1:0]       hbc_dq_OUT_LO     , //psram DQ output LO signal to DDIO
input      [RAM_DBW-1:0]       hbc_dq_IN_HI      , //psram DQ input HI signal from DDIO
input      [RAM_DBW-1:0]       hbc_dq_IN_LO      , //psram DQ input LO signal from DDIO
output reg [RAM_DBW-1:0]       hbc_dq_OE           //psram birdirectional output enable
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
GHliqnbjyhdOKw5PsVae35eOXrfTfukwv8PACkDlfUBWNxb0r4+jdM74iAF26zRj
qksLc3n7DwtlZN45LhfmCgZMJ5n2jnKyAPobiP+6g96QBhmkusv/mKxcbeRZpACW
qXEwkuhi4vRh6rjb+7MGoUixWP+a5Aofhm7St+aLg/k=
`pragma protect key_keyowner="Cadence Design Systems."
`pragma protect key_method="rsa"
`pragma protect key_keyname="CDS_RSA_KEY_VER_1"
`pragma protect encoding=(enctype="base64", line_length=64, bytes=256)
`pragma protect key_block
Rz+TLstPJZKh13HHnpy54NNbOnDADmJSu2kXAAai7sSLHDAfNkfVC+kLgo3GDGx3
eQEtoKWYgkxj17jLYhE7cg2aOTDx2txMQeQW4uygHOehbf7bitoKp1K4HTQ1sIoW
++ogNqiXAQ0CyPpIm/2tuJFgsu3B7+bUE0XWsR3LgluhIt8XMszqdng5AZPMxWY+
sH/N24aJpSnFX4Y7BSj5aUanw7uCiFVFMKHQyJdyQ2hGl7S9bf3YANK8VfbyziDy
SImhssPhdwVUgQzpmpszY1pHIWc9OYyawYFhUi5BfcNZnZYJ+EmHtk1R4VUbM9uC
ietmpRrmFGHtEP/1NVmCzA==
`pragma protect key_keyowner="Efinix Inc."
`pragma protect key_keyname="EFX_K01"
`pragma protect key_method="rsa"
`pragma protect encoding=(enctype="base64", line_length=64, bytes=256)
`pragma protect key_block
j0Bj3xiyaDrHAjDR7zUQEHkPOqByMZEv+/5w4cnJhQNJTvI4Wiyv+N/+ugySXbvh
Oeg9Dx8Wfq2a0uvxVzCDTgcoRZZ7j09eFcEg7SKeGYeiKQOv2oeGtBKFV5vZnc9M
30FpzIyFiG0AQJHeX1f7/CQ4WV0YvZH3GDNWAfLSr1JgAoiJO8i2tZ+RRgf0hrx6
wikeVrpg1vv6hb1U2PUJMYKr0CimS7Mnm0tbgSse8G0MXMprrd/wCTwGgXEcslmk
9jvdU7/MiF7fWncgz6yXzNluSggHupaziYUguMrbFAgpOTGVY8AX9ORwec76xfO1
Pgrli/FL+fpOcij/z7SSSA==
`pragma protect encoding=(enctype="base64", line_length=64, bytes=20848)
`pragma protect data_block
Hfb+EXBkwcJgAYiRv15zLz6KCRf3ah5Lre6rm0JVMLwJPGTlt18CpJVRrVjezkGL
4GiyrgceHXx/MkdOkob594G4f/b+ju6svx0yqATG8vZZfA3RGcUqjzKAHQhbDyC4
jmOJ/5qsFXX2YN1uQ3NaNQUhaefgfqt29NDPGwuVIuxsK/cZbu9c9A1WM/wSSMZY
EVQRQ299a+/fttd+4ETQf4hhHW8AWWfcnVyqvl7t2AxoJ7A/8fuy939YeB57H2hI
serPwQtL3D1059+RiKSbpRuS7Dni1y3raGhrhVafcWHVSnB6CoMYw+5G2yCCHX/j
0diwx7u15Ia8wt94DEfZZ2LMcVV4UO5QtOgVS9vynxJ2dcRv0E6z5NfilIklOfHq
uKB53G3FDlDCr28BoKNxV3UCtwDguivozck0MdKUZ89m+K5MDjSPQbujJ78TIFNl
5bSPflsGHfIvAzAh4mtbomii8u8kFp8CxtdLfYfIYdl50SvXqwsLe7efbGYjvBNv
N32fHhHZopdDs6i4aTT+4Me8F3KGsVLaPg5UyW/OVgkQYN3+OhreMXhhr+0csvID
py3391lC8c+TfrnmutW+H+GX/scW+V6x4HMMfr3QCt4RpeJBBA4B7knoi0oQ1cHC
DyoFbdDYQpJZwhwFC7MtXrHB+Uggigjdz2ZIBH4RqznJFXWZcmRo7edZtCtvjmUR
yIYO5JvgNF93R7w71wx5PRnN4DJTnUi5B1wKTugOR3PYA8vxjwCmxY0nJN+aW00D
yeBGwnAZccyukZELnzLmkJRklfMzzRZ7QCs4fYhERcGYHSTxUNfekq3W0FlzboD9
LlUPty39al8RSngSMFamZ3GMOy8x1QkSDDelRbljbZiMAuLBTZthM+ktm3dZMwro
LwcHWzhGyOR6UHRjox1tRgnyhPVCoHcnSPBsLi39Ypl1v/mWYUB3jj5eOt+R89G4
D1MOGEBT7Bnbsdh+4MC5dhKXkB6ZjsRHU4VvzviPUzfB/kODqSESt9gWXcVpmgY+
mRlNHNQKimw4UXhrBfHxxynu4uBsESLnrVkHlc9HOgiUnrHhZJztIudd1EZbdD7f
AhW+awImlFnSMrtOll9SDZiw03meqqy0bpIhs+7EWlRo7qb3XbOx71Ga9kiPkim4
MfnB+qUNWs/E6BNLzJLylkkOerji87ynW5ruU+CywSzOG+evDwqNg+f+N+EmgLTL
gd80CLEyoaCmXkPvR84wvlFzUm/evxpM2t2cat2Af7mEzerLoj7drtpppd94Bux7
4pTTBS+M6RUtn/or+Yq1veaJ15GSQ31ZlhOy1RwrxqfPzCIXHoRqinfUAj4gUBvs
9EvC/62pPdzcaPv1oIfc2P9kHccHg0T9w6A6rA79NtV7vnrCFg+tj/lvvZSFA28j
tejufSYq48UTWIt02TcZdErIMZ5SZUm9Ytwp5l3TtGJFEOgM1gEh3IO798F5E8p8
RIG9zRowWOyring7FY0om7QxVVLIMWm+5AVtwoOk5JyFec2fwMZdCzbJ+6Yh9diV
bXMmB35gpvCDrJw8Z3tNqysiicNa2yaqMS0VRLN90BqdYYdIHk/zXWOE/u8PSI7w
+DVd4xGE/7n8o+C7y5WxvFNO9nEal76X8g9obv7L4hfDAaiuSvq5ZBgnsdTS7Q/7
UBlF2DvlKczdnqmmi1vmQCrGOIHVb529pZidGXqbziTnqJEhVHsLpSlkbSF/FDtI
n2PoBO+gvss3qICtH33rCVUW9F3rFCTq99YQen0qTsMf+fgH597yclkqV3EarEtE
9Zi0oX/972xZ0MnlnZiNQZZAquIIhMhwncE2njRAA+KH0LvpCUZaSqXVkJMTGk1o
YCCGDpvEEGpW+W0PUhEWLxQaFmESaT7HJzI8A0dh0D3Gc35koRnGWGeBsxdKuSbV
admq7ki6OZ+17CL5ALd4geQOSfMQgAtvj+qmpmdBPeKN4dr/zXl3HKL4Dr44S463
QfmmGNhsGVko21hLR7xlLkXlhBMrOUbPDJr4DB31d4J8YJEyTAenM/mxgC/uoKQl
tVYV6pCz4WzjiPq3KV0ge+k3psTS0d6AutzpoeHhc0YGdL9oVjxq612ZYtB3j34y
J4sJFWboxIlpi4DZwaFzny9x8ai+gzMhjA+JFudVj5zKlmM4TgYFBOJD6x47wGZR
QCBudOXmp8+w4Rb6IYgKTRFV94wXctjYNze219PVYK1y2mxj9p2U1N1mrIlbEDZu
jt/Fv0JxsysvboTSRu/X+xU+s36aClVB3suVTwL+5sv2q89FekLueqv+ICA2T//V
kxZTfD2WfOxJVTuMpbaSgBNTnEuQjUvBd2lOlbujnosCrn3uNQNZXbFFyBLaJZHH
mOEla6qokWgyBSQJ9MsUjZmTDlP5owkR0xHxdMM8oXjdaCKmcoAB/5IT9HRHFUL5
GokQR5vpyb/jfB2hjR47GahpSOPPzm1hFNgosma/t+6EvSqmQOklUa03wYJwtxO1
jzQdsZi/oNEBmBXrmi9+ht3cmOWjzrznS6EwOlPaLUClGfLBK2/iUcFXuTZONcde
OTmqFxJjWHA83ZV0R2x9v138d5rvCcb/TSdeU4fmJUDJ8w9p97t5wBQXmZMnnmMJ
P2CihO7p1PNYhDrNdyIi5swRjGehO+LeFD9sa/REja9k6c8DDNLwau6pNbXSHzsO
/iEKkQneC5Dm6jHQDom8Z8MkhcVZnkMbIVBuOLeb/R5kVjqUXhS/GzUqZshn5Xsf
Vib6fJmgrEP3cB2QaTYWbHXQ5rIykxC/9DJzPPRsy2mcZt/RCgQ3dR4FVFo/Kf/2
yXDfmSFOhjgMJxluIvZwb1gQWGLawlKme5qYv03/Xjkd0PkrNmA3Qs41Lk3mLREc
JG4+hLFNfctkobWjoR5Xko9Vrqni7oamzt7qnmx/4eSmF/+RQfxx7NoLV/xJnCil
VbESEm+vAaGExA7r1HWldiHXq7G0X9IBuy34PaKTVnCzeiUI5o2AKFoYprRv2CCQ
US9G+leTFTcM9l0XB9jE6YGjc6ecoK/1obyjHRvkdNX2hHU1izfPa6YbSpGkePBE
tEuuBCQzmfxIHo9bNAMqzDtgIsI4Efv9VYeg41hxT8UDiqZH1rZWI3O4p1j0PuKm
QGD/T9Psb2LD71KcJQw9IsnHf95HlDNVT2EuRTmi/w4Ppz+ZMzhUrxqJ9rCJGKZm
4OeiCSbzxOjoVoB7JEbH+GrxQl7UBGy1twlw9Y6jv2YSrCrbNlGeUExjneFmxIGh
VeEp+gHSfo6dYgRlW13+WlGtKHBorTqUyxJN77iMuw6Jwbg9CiAgfDHCunnuVGsz
krSAigqpFPa61BdnPmJJfHkRa3sG5fsUlwHcvbcgF931hrOVa2/rYiJn50VVJ6Ah
78GWL8qKbw1g34Ii0nCK7FEgokFGfS/HisDsIn01XSNM0d6h3NuHA3D8PxxFvzqC
LbESBr6lFqBuVE4s0AKun0fckRkOK7uTRWq1bdy+ykUTeRRlldeSRLJYsSjQS1gv
NgEy8F7RvMEsPNMGwjmZD0WyvPM72vybCnT7aoHPVb21RhaFWbMHUl0l99tlwYhG
XP91XqGP0s4d6W6hZ/bI85x4/Qc6X47ANmCufC1ARx8tvaZn2cMaL5uEe4NgvFJp
fT8qjysCnlsgNfczNX/M7ufutrziplJe4FRzW3qD3CL9COndBryI4UiSd/K9u3BJ
oYFqC3wz5drdZQI6Az4D6w92tkoqL7iv0tT0BBvB8Au0I8WIg1zFVPoee4Ia1BD3
tp0xcHCTDcmgYYQqyqX/00iA7/Ai5WGNCgKSIQgs6L+nKZscNUkQR1W8ZMGNkNHP
51JGOC3OPlYg9XtRI8oeKpuG1EKZEXB9wzfMDIqhfbQQR122Fd8kzY+xE0GdToB1
RM3M70lG4ev/YJldHyZ0HrDI2faUH+2SmvlgYIcukRUonOsNlIhFmcbwf7WROlNa
OAcW2nITWkGiOxr0qpsIVnBEpQPO7VRqwYYjAUapevI1MyEbYY0j1Rnpg/t2Lphz
dqGwH08bRCX8Peo5dUd4JenAWRUvvtj0ypMfcp591UIXd9Gy9DqPsUQ3V67V3mnT
msqLi9uGXhi4eN5pmmlThOaPMdWbGHTZh/Fg885sNXGFpgkPfI8eXhNg87D1kzyn
fUQFs9BYTS3x8AYrAA9UUGDYi7WBHVkSQAycHE1YimjGw3Q0q8afS+aIcvKSfQ/J
X2GWwK4AsJmzyWdYcXdvD/FoCyZNZo980V2s71RQzDrmSj0t2u0fa1ByVU4QnA1m
w7zbN05puTx1OxId2dq5LVp+Fiq5XSFGzCf07GZ8qMRZLDO4pBMwQgsffYAoNFv8
YwSaMIRUkAJyVtOZY4rrBw51mE9jssxQqmlXkqtuEzornxFEDGd4ETok13OAOTwo
+Kez93wj5O7EECfkR7jirNx0IoI+SiGFoQiRblvXGFdhzFti6HcHyl/nQ5Q/lWLq
AT1MFpR2wvB5nMNXeAHchEqsOsbF5665L5gsenr7cACQ6RSuBx07eS5XQFjG18UY
DZhIGi/XQ7P5a8EMF+S+uyA7flWa8OTxfY2HJ+4UD58dGAmV0EYkaErFCjUxIFzb
HpBHW5sjwf3j6x6IE2zGekQwLV/5f1WbeuVqVjuH5dQqXKOrXyE2BMF/Tn/0/bYV
7pbsCpt+R52PZZN7BB45/9nml19LT50akdwNzNq7zMkxroU3ddtgzhJdylelU2VF
Hfb/PweQa0znVki+FNXzGzRGfmFGQRW+P0JRv6lzflThA5+FAooAscKp/M451wql
1KfzP968e7V0n/UXOUNByIWgNc23jQ3NuN9+/FppV91wATZOjLBJhR2nY1BYiiB+
1JoLm6RRl2XQ1qdqDELjusSI3XEZOHOPcwSGtzx8leHWW8GPYNYyu9elv5y4RtCw
QnUNIZQis7rslpzBisXtOJ67FkiDN9gAgmQhRX1KVQ73HQYnEVCq3rOl7DSSs10Y
53hQn/kVJ3Ku4EMlTbpdiv4CpIisZ68RjM76/XyP25YPBvlABq0LSof+3jorSXUS
K7/XT+nh00IyzeA1OQtSV1ofrVITtrHeVCnUFSS35bcoKyGrdHm1j3DRwvqRftAi
EdfpbvmJ0Rg2IPqhSxtLhJwNsFGumRjqTDaPr1ohe/JBfAJ1aJxj3y+nl7kT5XnK
mJZbn75nMLcMDVsVGEDXZGn6P6tjalLr1Bp/qm7CJvfPnVLB97+mrWzbrtNj63X4
xGQRp8N+Rf5fn0C5c6n6gNXxiAt6Ipl3apGfb/qGsEB35KGzNdTLx4kdPi+4xx1z
akTJD1qg1VntS4QS556vfRW/ifuUfDLbvEy8HbhDKAHfUk/KRqdIlnZl+Qyh1NUV
pNhxkvmcoJRd2XeCZHqztmgxBb3FAGDFz/UvUOmeUkwZwhCy+phZCPyyOet15PwU
vPjfzUSrsgoCIofjsssA8qcu2GiTW0wLSGtNhJMoQ8ub53zfEdlABC4b8V0t33tN
ko/XuptdlRAxjq6HZstdZflY/akmPJ2NTFBePDeQFh/bDmf0EvkoDu4bLvFVL9GE
CMi69sqwe+civBvo2dqzXr+LU0kzbCCd4UZ7UwstMGNhy6JPVdyrbAtfgThq7LwA
F0abLx2rQJbr1/J14x0c/OCIup5CxDmoBpTanB9eeKyt6wOpJ87wqGKYDfg8saD2
c7kBljUl4vMcUWdV6wqkWN8mVJub/1cwBuH98kawREnmNWyUQ1zyeFKSgOS1YMQO
xufnLvFVf4fwOrndg1sttN9dmvO1+WszlX/W86rNCdmvsWG2A04hu+etK0mYdrMm
rOm7K4eZmzNaXUHnA8hfup6X7Myqhv7bgYXZBlPAb2sn8iw+N9W/UtM0UelT//RY
LqWbEar0MKKFL9vTdCVJS8y/kqJPhsU6ncbohupHx/BJ3oci0oUmHQszyz8iaJgo
AVj5i4TskIIGakaalzlynMaw8D/1JdkZwHQQmsWzN2QiLQLHuHKfW+5kZgr+kDtC
+Rwnd/dwACHc5NhKdJ5dQBUpV6V7LUF1/yFWE+iv4HgirDZhMwhSH+oxDTuVpIjG
te7g0RjIooyukgHsJ8RK5mu4mYctJoLdRfN8nvwJPyCpR+e0kcf2s0AgXjouxivf
DKnXqnfChTnv1EmnnLVXOHrCJmwHPZLBiT/XaOVgyudlsn4924RhSB4b7kyrXM8E
O9vdV8haGrH2mtBiZjhCH4nRJaaScppERhsQoo1gN8CBPLriiD0y+EXDq+QAgXKO
mopAUQl1WYAF02XNvk6OkRUkQiU2Qm3ZkfQC9waAj86Fr1Lm/vXyNbTHm+JYztPb
zy5qxozT4/b159TNxUtXsJ6DPId/0AroBs42pw1+2MQW8xrl5RGDQy7Az9LHyL+4
1QnK8inL5dMoKmmRol98h1oUfa/9BdsSqR/wN/AQ+UXVR+Z2sPmvIcJXDkNG5ng9
KMB3hJDGrxvwxTZzHv+lXI2DUna9rJCjkz3c0FgJk659dLtysSR4TMVYkLFR9VH7
Si3P54DUXG4q8F7+UYi35Nk2nNhN7MmZtct5sTBIc0+E1JkdHkRnay7l5duth1A0
t1TOJgHUpFxWMwRXNvMaFOhZJNiZeLSSCAeV8mHegA0u64HGt73XBHyP+ADdaOWq
su1jjiMrQyO/CXqrfRS7oiWyGheA+wEiqd4gWmG3yAx9Rn6PUN/x4tzdzaq70zN7
Qb51oH6B37nJY1HLo16+XUhMPCmKMDYPlrNNgH+Wb8poRgR9Hq8HRA3yPizQaLoW
7do/IlGIhkOGumrwwdyQJwtTRl+CI0et+kcRYoOY020xXoT4MP3hXHlbpu3RI4yO
B+3DkYpjfKLUoBE1A2L6hZP+1lPIc1MOLJEpRDshwWwGZgpIGnOIHtWbor58Io1m
I/QB3JgsAg1thwu7KNAq/0hMTZlbp1QXdttPC/natAoqfqyZ9MKeFgfFtm+Y9VL8
zXEacaSwMkS7h3KrreCzvozLEqI415rbL/3C1gmGUDkuNJS4vtfY0aHz+OUtuxOZ
hsi3mgIT7xmWPGkQSBvziRs8wwN0zFQtT+B8ziGmjhEo8DAer2BNrWCOjdCAVErK
YCygCV0Vo8UPN4lk+y+R3UQxfHXGrLjxJWXr3NEsAssStZ7+vORUsR1INk87JY/4
8s3x/Fa582laBRJruhzoYfnNbJ/zrRHY3kpLNvY5aetHTTEQxNACmRgolksrcxT5
Kh069oAkyv669HB1i5lIdcNgtfkERt14JmVxsfiiL92OWw5zM4m2/WsTgZjpo9i7
z6szwupkaJQNPJYmCwjb/VQEvV4NYxsgpPmZ5waLv/EJ9yfCB6GkHR0lZFdGc7qj
S+sHHJblsPxSCsM2pK0SHexoQjtlc5DAMMla551GCFzeprGk/jSVUXk0fu8uj4we
KhLN0nuGykjQGfJud3y5pj7D8e/r61C19R57Ke5jv8sp5XiwHKvwxuUVCaE1//D4
FSWzzDuOvtOKTFjEzAw+9HpxILRkF1hzC5TSTK3jL24Gkt8ukjT8NwWadkGSntwd
JvbENT9pcf8CU8g50bo2JoviaWZIldxyMvFeSFxS4k7b/0tUCcCw1HVMgtttXF0G
rkB+5y+3gUyJmsBKv67fK8YPq3IZuCMJoOMKRKCJ+HcAbpXHkW2uWkLkK/TZl333
RdALO5NakQeMlzc7rLpDD59qBSWiecwOryBHfpPoquWQYf+Hb/2RX3t9uSsufhyZ
zF5zLX7t6EWXY3bpYczSZhB1T71/lSe/a9qUUa3slAGrYYG0WtnXh76NNmpRi15p
currzMEcdxvLC4Q2qljTu4c7UfLZefjUmaru39ofxcjHp6BEtxuq5Ndd0sKRFQY5
U4MtqPt9JJRGftN5Ae9iCOWI+D4sYnvHVk4ejJsXu1m4OC5fAcoNp+fH4AM6qMem
+tFLLpwcqMmytsK3MK8UD7MdnDzV0sddqTwvwZ0zHrU/86lc+8Um3ILhYSkn4cHL
DVcwX7x43mYlgzyRcUBgJl8xjnZ3NdV5X/ZF9AtALQBqLH7oP3BEVOTXo1fPSu8m
AvJeW3LP6ZRs2/1QMblFziQqjI9ZP9/CNvOpCq/jJhLhsE/NCuTmXLSvJp6rhv/H
PGnHJRpCsklB6y9obTPWYH7EZZFCHDzWFasK/VhncU7O3RGc8QXWkDuGkKFfIZax
mCS5EmoyJZJYi/ec1IyDyAfs1ljTwz5qeaq+npvn4pcTsfAFkTDbFbS/uIVNm/Jd
o8uBoQCb4DXvlPhfgd5Jv3Cc2sDhjQM0uaxVltrDf/v0YHRSULg54lIgFRBoiziw
eJ7kJFVhtY9Pq624b038qV4vWHE3JaCB4+YJfxB0DkG7u+GDHB3/ZYi6+OmF8Cia
5QKrCAVsgo/eY8OJ49mXIRtJV5+M1zG2pKe5zYlpDWBbobNiflN2ZDwAO0LTT678
mwrQs+kMtRVMBgDYX455+pT8sZP6g0b5zbbs5rgBWIfPv5NDwzJqQOfF+yKdpdOq
YvDE+7TUUuACTHTXXzGIzAp8jC4ftjbPG+aZPTz4DYxb0QmJ+8W6F9gkNsvoxY0/
+q4KHjIzuw4KVsZqrgj5YRZK7G5umyqehxdEjrbsyoZPAos+djqlKS+TIzb8kqLK
2u2DAm8+904V88WkmBPFrzpYIkc2oKwTXwSd/DG/IhLg21lNEq8IqHMTD342zNNn
yVYLuglWx+yPdKOa2DyLtOx4kCvG2feEdFMXr2JXUMpTcFUCCFqeHyyLT25NFHfM
5J30cMJkl+VWSa6y0UWWVOl3XNQV6RkzL0mwJ1MjUIQHzVBjNAEPo7Ny7IAHAQ2x
kGQeM/OaUjHXBsBOrpFmtsREnwSW9p8n42DTRRHMzuF7gdOARO1A/0OsTuZCLVAh
ZHZbs0MNt5OgMi/N5xE8qIvkY9TVaG026mG9g9ffPdyOFGdNle5SRURA0TbV5D2w
FAVLnqf6adyKa/BDWfYW/BWcoNfEuaJ8jXTBZjRkEag9C7QxSy5oA/DzRwgfJ9hd
por+71W5ApmmGz04AlOO2SJL9JzMZ3fXcVNZwALak6C3GCVpvDklUxFHBjyQOpiF
ib/v1EBErt9xjZNtASPw6BQVKJXllcnHdiKXXMC9X4jTOW/rXKbtZ/ORtEeXI5Ar
J5dM1VcwqarWZaDC4naaPDMEnQ5DYEDLfK/dQnIO4CrJtbI5ljVty/2wSnHedrOq
SUb+ayzcpsKrtcNL4/wOVy2PabN6AMb5jl32qHM4lp9OE+qVGXsz4U0Wnj589idY
W121i8g9m1lRQdYEKmAbZQ5C2z2JRyhk2ZO7sDAATxsCBJclFGiMoZhMzKHBw/AC
VhCtfZuIAF0C7CWTGt/AwKzRGqS5pezmh2FFtMk4edtyJM6tQQDbnOaDL/3DGawg
4ZszUosD37ACtcHu3iZa0nqq/nEmHtbs2PJPcsrdqcN+la4qLOObdYVPGGcYczQN
bB1X6Y/SRgjqzdM1Onyj4ReWUpnyGLgMWf1KHxCOFdvGrBwPk4dkjDSLdMNUkY7X
otFgY/lab2qhhJvrpkkkcxlp/SgrzRcBJlVK6y+wY5aI3xVE282MHfwq5hmeFkmV
ZPi32pGBz37RfiL8nrvkE2NOrmLOwOjDVuEva00ximo2LnUByN7ZD8hSNDiXx7lR
Badq6aU2Jb3LuqEXPwKW5UDvEdPK86rS/vdfRagcDtNW7IvGuc/Eit4DYuHq0V54
Gu/QB2saCbCh/yHSS6lZyA02ueBZ8vW5kQYtpZhLQpn2ljulrNaWYe34q12ktIPU
UVDmBQBR73kk7rfUJFvJF/LpTDFTQfi8mV5d9NQVMfvE4sBjSdiIMH/IoCr1iuwz
ylbT1zDjDuewLAmvYnTnKy9WcE9LGO9yHa4puoIh14pwUnzXzlykIyTBbf9DCt7B
hL+V9EPbGpuVKv0XjQ17KMVPC25Fulq8Yz4x5aMRxae1UR+J7pQT9J5E2EORpc37
R7Bbjw5kdNXQ1FZ2v6vtzkYPP3LSHTS9gOFunceIDudy8iPCn6Zy5KScLZoaLVCC
reWKoU5nAef+Z0EdeDZmOl+g5JF1EBZToicbfIW8WqZ7JPVgUopNVsmAbHuvyh11
ZaLl8a57UBXOckEpPKuK/pIhb+6GYxb1l4ciSx/jHPcs2c3zpMHcu0AiR1t9IoY1
8wUp07i/Uvq25qV/T9twbGQoCSrsgC803s1qWAKhFgr5XjdWtp4SqDLBDitqnP79
VlXAhAt7QQcRv9LtvfRrfJ9Km2/PmupkY29ZMr+/wuYdTtdPUPVVCK6NbW7X5CfS
RoBw/08ANQsL8MxPQWp42833CPC70jCnNHkb1NW1D24KTMnV3OY3HKCbLJXVtt3i
kQciVi2VytbSbO354bJJx0pKzH39W7j6LJo25//xsS3RghIhaqhFRioJdblX/lka
oAdvWWGNGhhyjbqgLUguZwg+y+GxzjHS6YlL5M2LtB3xyq0v9SqCQaV76cR0HOQy
EG493O0/eGqbyj4wJyqGvgNDrCe6HH+jer+lWwDV/ze0iWShJrttMaFaiNz8neVV
kKf/O9EmQ/6xq3Z+CdmvSeh9OP19HyjKXUHoiOS7GxZ/XFtTCnWJJgYhddmjLAAs
CxOqYtlCnI55ZAmJRn3nMPJuSXk+1d2tKZEEkSxBe6cZw3297ES7+hcpNsEie0XP
1/Lf8F8capC6KT5OoRHXXfWqhVR78jlhIvXXGMLhSmb7nJ0AB3vI+6fk9k69/FY2
VZy5Sba2Q213VeRGmJWkMJuPDWugg5+/ZukOOb3rbLWBHhYr7ZCRBAkZruaNf3J2
M34px+QP8Olb+pa411xw8WKFJx/heFve8rDSpuNiiQEkb0rQovQSQKnOdBoVZXrL
vkjRyZlamxt69j7iOH5RV22muVeiBd3UIaPFdML8KAcYJqYClmmlCx1524Ee5RG7
QyI9UXNlZBR+C/P3m9IAmQzLK3XM8sicMiWDCHL2BssQGCfz7qJ5Z+WHCvFrXNw3
6uQpo81EJ0kCzax5BFYoYHgkS+0ej6JwYhs0OXzgY6w+jgoDXdd0NwDZ/y/zd0Cq
XIzIs+9d6HESboj7q6KjTP/7JBnOoMc+GdOTSt6czKL7ZLL0TFHgxbwtTAVAPaag
LOrDFaGuCQ9sjwma6322ZvdpXGnimFTMFt9GkBSe7mRCnujFBahzwSa38ssjVNO5
IRBDgbhZUpxC0KcWPW3dOBzW0ARoHLHAVyp/hLh//fnt3n/mKTwCLCswmflVPSKn
tGChrVCCjjRQMdAV6jG0SJ1e+HpyxslDR/c+EVFj3UogkqLazutqkvmrUhu4ygIk
PhIswjfO62FxUbiOVqWsC2RFIdgEDDBlQMopICYc16gH2F0VCvEUVTTVgtSJp7Gi
ZpMbxgXPrgNhHa5AA55WhqbmrrQzCtpW/Jj21XkbSeuh1ZtL/uTz6WwhlTIRYcF2
8+fNkBjl8J85JggC0p8DfRiKFxTn+YHRL7/ICktIHoAeX0Kb9OejbYTScIFfGcKa
VSwhcjI3drvHlNQEwoARE6/c7ZnLzarQq7mnnIgJxmfXd82D8ed/sy3CTmGXJ5ss
l7+b90b2CMVQrVUXAPNpFHhQ3ThPIrQuBRQVhBJHezCtoaZOigSBi9v3yBXnvsSB
rQEFVqTQH7DIZka86JZLI0GzgqXcOVNYjPCiT1vVeqcrpUuRpamnS8KpWGp+kj3a
PLOocRWie4pPj6JueZCTVZLuOa07Kvkq+/cpP65IX/bKQ38rE9IG0/FY23aRJVXJ
K/HAkRaGcdKMoMWxB3FFWrQS+5Q89Zeye4nShee3KKA+FatJ25wi8FwxQSAuHJg/
JE8ke3qFG4X3SoKVcFfZgEPM0+2jbvL/+r6FTjnuXgJ802mYSRLy9b+JPf83ln2h
3osytqcfr+wLpvzGTIV/ibNeEfIziD3NMjBwS3O3vV/sZ9IpQrCBpZ813E6Diha5
go2gJYippHsf+G47D2ok/dwb8WKIlhiv/sFHcFohYSlIVtZ+wV3Kjl/6uaFWLizd
xUkim4NQsBFga8+2OXUIx9LGKpi1sXY9yOT4oZ/Lo3ig6PuAFx7gTcltM66V9jEn
a5TnUDqtFUuQoOty3NgH2dOned4kv5uqrvA4u/SPEOhwaiaF/nb1kIWW17I+Q8i8
+skfVrEo89PmB/V3pJH979jUX5jdId8ScF8GX850AvzaYJTimOn2lg4KxPS/D6Dh
SUgWzmWu+bCMyZ4p2TchFX5Gb31DCBrL1Sss+G6qc6BFw9I2z8XDrXejoBMVVnHr
FXUezCE+0NDzR1Ex8baYOYLgIC9CZ9iKdSuZnvAZft0EPQ4c1JihWP9knaMeTuJW
XbkKdu/OSj25ztOFniH/Sd8lHTkKQl8CuoQAYydr7RCY4nSLlmIS/VDfinkQcVlA
oHJre/4UCcRMfoMnCNkFTe97f2mrbJMLC47mBTaUSgd/eBOWJe6nz073V+IzxKGc
Pa3wUrUq0ph25nrS/ZcaXn3A2lVgjFuAlkOeg04cvFYpG/lKwrfglhPGBMnj4YeN
bhqN6039xgSt8OPvknpxGPyaHH1CdPMQ+sDk316tNhC2tyepPW4+iOoDzLfA3s4Y
Z5jUwVYfsvjqHYZmI0xPOPyekzyc1Ew0FmQ0f6kau+dL3r1UQgPhT1xtEQsSPK0s
/azWUcbx+4FNrmhlMCGDuIgTZRU0OUFwf7Yr1JMW+Pf9CjLkKXw9OWbPcEGr0H7p
xc+s2+4PWD6dXy36YKNU9VHv0r2QpYw+2kVvQYpwlYXxeihULY2EISJgr3FF1Frv
UNJkucowvaauwdYViPPZlPIW4hzhK9LushJZ3QG2mSWaAlP+/q8bq0OZU99vMA7G
JarJzdTlA7aFF1DJgcZJmjn4ZLKZBSguL4hOFHFu9F7QVrMVXQe9tOnTV+o+ZtVA
1tQvleIi8msxlB7twX6EA6NFZhzzPYUdP65xry3xj9Fn/mxoQSZR/QcbnHuias2J
4T2/xrSyj/ZYmHtpfy1JX0MB0q7qVd2RbqVf1PAUv52PTOV2pi5gL4cCvEkBWIHR
JUum7nJLR1tWac/heaG6RvxUflmgU2sWNz5mRnPELuCJHbZOCBqn5M1o+JSuFcI4
ZINzXWT6uxVR+bJX9Lny18htABtssbST+rov6l20e2bNZaMDF0QlKOWKrBbdhMV/
gM0E1+jlVOygDi6fEO26RgqLtSF9LAaYNdBWoUrStlLeNRYdIrdpvP1ehQBFUc52
hsx/0ZH18GPBaHntVYT0o1kLKuHxW2YfYrjRGJwH6TPBSFTG9hqNSvLpQTlkdpwQ
DfVaiLGMP/20FDgXwSwAIMurVlfHHZjSqmg89zzgjHQ/dbjVIGf8T84nGDLHx3u4
eerxwZnjWagUvkzSjwbJqUOahGLTbrBHXTD7diZmeknj0Hj0fcma6uyaNvuN2AVG
0chnhhzsoHUHPNsKKO7wROI6tGK79rNgw/lAHV1JYqwcv7HIIzbKVoFmPj04pevu
F6mMwpqA/Lz87n2H/MYbOMaau9Iayfrazfops+eIpc9liN3L4DFEy4X5K9rmRroF
OA2O9uAfiDCeyVos45+tLK/FXGJmPpaVYPSgChln5G2Edum5h7L//kNPY6nE/TQb
ROxofXvFzr7sekBp4vftoEKkiszL7XScno6mN+EWuHQvICsX+jd4cfjklL/9XYa+
O0x+LF3q+NM2cAQrhWo4OqhlJqWL/KjdElyWHlrq204xKn4dxUH2yNwKbll6iC1p
F9JLKsQT2megP4qN1fzDruuQX1/Mhg9aC0EcOfJ7MvFZpHqvM935rOwE42GQHJir
Zmv8+1tRntuzVQL9KYr26ae72xd/+TIXtM0hRj3YY6hKlGiW6zHv70q+3gXMmDzG
0G8Pe2G9QQ8xrIXIyClv2o3jhGGYGRCdpvYE9ZFoE41j2PZhlyIL9sDe55e7GaWz
7jb5g7eyGAvwVpluN5JqK/r1ysTca46ffRhG3u+e/9pEE3S66IPjgH+qAAqOCJrQ
EE7DFEuLqjSgxUP3xDTMbke7tem/2HCx7AzpG141ggIKAipWsbdHy5PcAiuEHYC7
g7K5aze2FQ1LWRwjPePGtsaQEJwyDeviEolE/HkM3Oj2pGHe0271dbnl0l9vN2K6
+coqmEBRJxqlz2mbZpuf1jB6nKGKw4hH2nc5uylQ3m+XNDyfB3DC4/tUe1vQv0h8
VKzaSLZyIxyqCnDlEJ/Z0GwnkqQRAcynMIbwnzcZYxr39DDDswI50653V9USceW0
OJDAUcraUhUtHUNfZO9Vo6nBjWd8xDL1GV/6EfdHORE9cvcm3nNHaeYs6z4RQXan
ZutqwXwkuAWAlyY8S6uSZPl2qHpdS7rS2SbvJeyRjcq2/EuNg80xbF4tYvo3iP8r
Lcfw9DsbkfOgKtHd/BIOcARj/yc/yLCIbuattSDlOxn/kBGqX2HD0iQxZDrYb7p8
CLeChRja3SyHCCvChxJCBr9jcJ3plDCNBXVfE8z9bI+ngJoaDeO173uH2d7h2Mpc
3IJ/XieVN5+V9hw0+8Z7iD1uXS8fmVXSi5tNzCWba/i/nFegV0cm104ukjSBoVnZ
ZVY7xZV+CxVqn+P15zTA6dM8ahYikZeuuio/h9ktC6ICWk1rEivMeOoYeUPF8JBD
MCgPvUF+xPsDr0OAqj0C37+3f/X8ruJxTkjVQ+XWlEYgvSfSScpc4bT75qQZwnvV
zFZRCcjt9P/N9CtmkAgMwFvq2kRE1e/zIvXscJjy0aRybWWC64fZ4T7DWoDF27tr
HJp91KwiIGA9QPBb4thRW8b4SKpf4IxRXKlAGo+YHLMMDXaAFv3f7zfkH6u4MsTT
Te2H80ksHGE2Ob7N25mz9dZjzuQ8gIKC1imHWhUhSKSHNNxOkm7f3Bh/NL96uXQh
BOLaf3X6NJpSnPQPduW7GIk41tw1vLHG66uGHOUmsZmRY5qPDFEC7wNANo7MAc3g
PlGvQdnW4KQQm4reDrRTsdjAiMZtHeysdwZ3n1pPq0h5KSbBarky9oKp4O/9qu87
c8sWetrDFrlu80H5vSItZXj/kBY6SiqI7SDi5LP2hY7+XZw/MQaIQ62DQbyoi5t2
saIE5PLUOWjstqVNoNWxpSsCL+zMxA7b9ij1n6XEFpevDYsd4QCFbb3VmSxfPqvA
3+Dmo4mVXRh6Fkg5PeclOtXpqMCOkvkUa9nMEsCV9V8dcS75fkJ6rzmV0Asy9R4E
lf6yu2gnimP8Jh8ajbOyZYh0QBHliYtM/aC8cVp9IkoqucU3BnT5p8IvVC+jQzCG
x00Q9Z+KYDRgDcoqBWvwXtAk6FPkgGrw5U5PQZgc5b2egLXHCssjkuHv7to4RkQd
V0iiT0CYcopJSLQUj7SSnqYjseIYMhmVlBBDDwfR4t6hJgomeWZywHe8V6mq+WLs
xd96QGCMXWqc7QxniBO95TNprCepRIqipzKelht4iwZi3Ov5yom2Thvl3XiM/cgD
h2iIKPBA9ZEbJ6XwD+A6KxOsqCStayC+zH5T53jJfrvMUmYgaUuEbyd6r/iC9ekd
8YDooUR2YgLLuqmZI39B7r+CcOJcfDhns3swNjiaRs/QO7BEhZpqpNEL9SwxtQUH
41/MwdW5NigH4TkM1ltX3JfmHB0zyZ38vjMnG65RnuRvLgbR7PCUyjn/+Rz3tY0P
4FiDrHcJvB7njIamu5DlkXHx/hWkr2Jc9uXcDmBVQCgOUin312s6rDguzbgqBlCu
cQObSvS+Rf5F+OkRhFZqeF4UNkt2ngwEQr2a8pQSKBN3GZwNgR7TZvEr+u/kShbJ
i0GWgOLUqlS+PDJkWWrrpFdUYLTOWVY7bGxAtRsjL7uzbXi6vI/6uM0IKrI8BDM4
LTmxfYXkouXQtBtl3ms/Bg1TQYpXA6VgXLrKIpWC5JWV4FFPXek3jsPBsnzcQNGz
1onwTlVZCS6KDKSJHDyRfDc2kLbhptEci7+G5JAwXdHe7LEuFCeQZ7WujRBFRt6C
XKHqI7f7ZroRInybLxjauO5QyfxYiWQ8UfcIxzkwsAjDTPfKvTKKRrDF0ryLCwnc
skPuXTdvkWOQ8HVuuw9D7mUHqEH9rrFo5lFvefrr2FgkGrYgdmGzetcGwoyTej6i
7mcGpZDFXmGP/KXZxQpl39g+oo0TRoqjuOSIEYV3N4QewRjPEZHQv75CvAFon3cj
z9z0QPm8RwrBXikpplpIwO2fTKDgmFCOUaLIXA6aqN/p6xpFpKUsSC0T+kSc3Z8R
MxkDufKAc6TjQtUFrCV1P4g6dmYn2WDZRVIRUXm0X5UoXbE7oM1B/oakg4XKq81A
Se9Dovkrw5/D3Z2GvkyMLDSLWbM6dwFqJwN4p83jECNoZcJt88/sfmxzwka0XVkR
i7l4GrnqL+MF4u82OfmaSkyW5+dZcwvVRbdqHIuU39M9eYoHV0r+F+LcYxULCfT9
jj0kDv9dNfvnOqz+/c1cRO/Y74JE9ItA74UwAlcPkulD2abog+f4VCJN5MfoNB9s
/XtT396P+61ZvRibYuPZ7WXa17Hbg2zwfyDL7wr1S7IpsH1Q4woXfcnxIFkxHxn4
QVR1X8kXP2ncH5h9g1vnx5zaJsaC7e5frxc2835lM168oJqUHypnM/DWrMLbKn5K
kBiPgakc46Rqi1Ut1qZf6KUvRLQkZMBrl29RDpwmzgmMOZACU1Lbpb7wdLA5XkWh
+NUwhH9XuKc4YbE0IL/wHwLFh8+/lAgSSD77oHTIWJAmwZJPT3gj4OJsjtBI/Mc0
GlmPOCQGIDGsNd6EAC9aIdb6c+feMLM1uqY2kABcDymQwL1c5DMwDKAypREf84Yp
Rje5R/7HBp+9RDcMagF3R2pniSKRoiUuWFEA/7wf4xLcLPR/mcrs53S8oo32EjBr
g1m38JPhOwl6m4QXSumLvGndrAGVn1As0wk1hHZvUyD5juC5/+CqlVmncuPnoNVb
LwrakEHwelGYusw7+fBHALx8Oo78xWRPl28VbUS1+wZpdBvS3RE4EEaTmOMxExIk
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
fYW51UCGYe0uZ/2WDFlncw==
`pragma protect end_protected
