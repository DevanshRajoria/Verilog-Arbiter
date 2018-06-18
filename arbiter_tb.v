`include "arbiter.v"

module arbiter_tb;

reg clk,rst;
reg req_0,req_1,req_2,req_3;
wire gnt_0,gnt_1,gnt_2,gnt_3;

arbiter uut(
	.req_0(req_0),
	.req_1(req_1),
	.req_2(req_2),
	.req_3(req_3),
	.gnt_0(gnt_0),
	.gnt_1(gnt_1),
	.gnt_2(gnt_2),
	.gnt_3(gnt_3),
	.clk(clk),
	.rst(rst)
	);

initial begin
	forever #5 clk = ~clk;
end

initial begin
	req_0 = 0;
	req_1 = 0;
	req_2 = 0;
	req_3 = 0;
	clk = 0;
	rst = 0;

	#5 rst = 1;

	#2 rst = 0;
end

initial begin
		
	#10 req_0 = 1;

	#10 req_0 = 0;
	#20 req_1 = 1;

	#10 req_1 = 0;
	#20 req_2 = 1;

	#10 req_2 = 0;
	#20 req_3 = 1;

	#200 $finish;

end

initial begin
	$monitor("time = %t,clk = %b,req_0 = %b,req_1 = %b,req_2 = %b,req_3 = %b,gnt_0 = %b,gnt_1 = %b,gnt_2 = %b,gnt_3 = %b",
			$time,clk,req_0,req_1,req_2,req_3,gnt_0,gnt_1,gnt_2,gnt_3);

	$dumpfile("arbiter.vcd");
	$dumpvars(0,arbiter_tb);
end

endmodule 