`timescale 1ns / 1ps

module toUpper_tb;
	reg  [7:0] in;
	wire [7:0] out;
	toUpper t(.in(in), .out(out));

	reg [7:0] vec [0:18];
	integer i;
	integer pass_count, fail_count;
	reg [7:0] expected_val;

	initial begin
		$dumpfile("toUpper.vcd");
		$dumpvars(0, toUpper_tb);
	end

	initial begin
		// init vectors w/ provided test cases
	vec[0]=8'd40; vec[1]=8'd72; vec[2]=8'd183; vec[3]=8'd131;
	vec[4]=8'd124; vec[5]=8'd20; vec[6]=8'd235; vec[7]=8'd97;
	vec[8]=8'd65; vec[9]=8'd122; vec[10]=8'd71; vec[11]=8'd109;
	vec[12]=8'd146; vec[13]=8'd48; vec[14]=8'd207; vec[15]=8'd58;
	vec[16]=8'd123; vec[17]=8'd148; vec[18]=8'd127;

	pass_count = 0; fail_count = 0;
		for (i = 0; i < 19; i = i + 1) begin
			in = vec[i];
			expected_val = (in >= 8'd97 && in <= 8'd122) ? (in & 8'hDF) : in;
	#26; // minimum delay: 26 ns 

	if (out === expected_val) begin
				pass_count = pass_count + 1;
				$display("PASS: %c | %c | %c", in, expected_val, out);
			end else begin
				fail_count = fail_count + 1;
				$display("FAIL: %c | %c | %c", in, expected_val, out);
			end
	end

	$display("Summary: %0d passed, %0d failed (out of 19)", pass_count, fail_count);
		 $finish;
	end

endmodule
