module sign(input clk, input [23:0]PAX, input [23:0]PAY, input [23:0]PBX, input [23:0]PBY, 	input [23:0]PCX, input [23:0]PCY, output [23:0]Saida);

	reg signed[23:0] r;
	wire signed [23:0] a;
	assign a =(PAX*(PBY-PCY))+(PBX*(PCY-PAY))+(PCX*(PAY-PBY));

	always @(clk) begin 	
		if(a<=0) begin
			r = (~a[23:0])+24'h01;		
		end else begin
			r = a;
		end
	end
	assign Saida = r;
endmodule

module triangulo(input clk, input [23:0] P1X, input [23:0] P1Y, input [23:0] P2X, input [23:0] P2Y, input [23:0] P3X, input [23:0] P3Y, input [23:0] P4X, input [23:0] P4Y, output saida);
	reg a;
	wire[23:0] P1, P2, P3,P4;

	sign Pt1(clk, P1X, P1Y, P2X, P2Y, P3X, P3Y, P1);
	sign Pt2(clk, P1X, P1Y, P3X, P3Y, P4X, P4Y, P2);
	sign Pt3(clk, P1X, P1Y, P2X, P2Y, P4X, P4Y, P3);
	sign Pt4(clk, P3X, P3Y, P4X, P4Y, P2X, P2Y, P4);

	assign saida = P1==(P2+P3+P4);
endmodule

module executa;

	integer data_file;
	integer write_file;
	integer valor;

	reg clk;
	reg signed [23:0] P1X;
	reg signed [23:0] P1Y;
	reg signed [23:0] P2X;
	reg signed [23:0] P2Y;
	reg signed [23:0] P3X;
	reg signed [23:0] P3Y;
	reg signed [23:0] P4X;
	reg signed [23:0] P4Y;
	wire saida;
	reg state = 0;

	triangulo T(clk,P1X, P1Y, P2X, P2Y, P3X, P3Y, P4X, P4Y, saida);

	always #2 clk =~clk;

	initial begin
		clk = 0;
		data_file = $fopen("numeros.txt", "r");
		write_file = $fopen("Verilog.txt", "w");
		if (data_file == 0) begin
			$finish;
		end 
		if (write_file == 0) begin
			$finish;
		end
	end

	always #2 begin

	if (!$feof(data_file)) begin
		if (state != 0)begin
			$fdisplay(write_file, "%d",saida);
			valor = $fscanf(data_file, "%d %d %d %d %d %d %d %d",
			P1X, P1Y, P2X, P2Y, P3X, P3Y, P4X, P4Y);
		end else begin
			valor = $fscanf(data_file, "%d %d %d %d %d %d %d %d",
			P1X, P1Y, P2X, P2Y, P3X, P3Y, P4X, P4Y);
			state = 1;
		end
	end else begin
		$finish;
	end
	end
endmodule