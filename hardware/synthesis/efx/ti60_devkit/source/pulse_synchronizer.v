////////////////////////////////////////////////////////////////////////////
//           _____       
//          / _______    Copyright (C) 2013-2021 Efinix Inc. All rightsreserved.
//         / /       \   
//        / /  ..    /   pulse_synchronizer.v
//       / / .'     /    
//    __/ /.'      /     Description:
//   __   \       /      Pulse synchronizer from one clock domain to another
//  /_/ /\ \_____/ /     
// ____/  \_______/      
//
// ***********************************************************************
// Revisions:
// 1.0 Initial rev
//
// ***********************************************************************

module pulse_synchronizer
(
	clk_i,
	pulse_i,
	clk_o,
	pulse_o
);

input 	clk_i;
input 	pulse_i;
input 	clk_o;
output 	pulse_o;


/////////////////////////////////////////////////////////////////////////////
reg 	 	sync_pulse = 1'b0;
reg [2:0]	sync_reg   = 3'd0; 

/////////////////////////////////////////////////////////////////////////////
always@ (posedge clk_i)
begin
	if(pulse_i)
		sync_pulse <= ~sync_pulse;
	else
		sync_pulse <= sync_pulse;
end

/////////////////////////////////////////////////////////////////////////////
always@ (posedge clk_o)
begin
	sync_reg[2] <= sync_pulse;
	sync_reg[1] <= sync_reg[2];
	sync_reg[0] <= sync_reg[1];
end

assign pulse_o = sync_reg[0] ^ sync_reg[1];

endmodule

