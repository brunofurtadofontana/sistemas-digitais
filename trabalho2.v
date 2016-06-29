module trab2( input CLOCK_50, output [3:0]LEDG);

	reg [31:0] cont = 0;
	reg pisca = 1;

	assign LEDG[0] = ~pisca;
	assign LEDG[1] = pisca;
	assign LEDG[2] = ~pisca;
	assign LEDG[3] = pisca;

   
	always @(posedge CLOCK_50) begin
		cont <= cont + 1;
		if(contador == 25000000) begin
			pisca <= ~pisca;
			contador <= 0;
		end
	end
endmodule