module pisca;
	
	reg luz;

	always begin 
		#1 luz <= ~luz;
	end

	initial begin
		$dumpvars(0, luz);
		luz <= 0;
		#300
		$finish;
	end

endmodule