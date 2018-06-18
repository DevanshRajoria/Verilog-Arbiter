module arbiter(
	req_0,
	req_1,
	req_2,
	req_3,
	gnt_0,
	gnt_1,
	gnt_2,
	gnt_3,
	clk,
	rst
);

input req_0,req_1,req_2,req_3;
input clk;
input rst;
output reg gnt_0,gnt_1,gnt_2,gnt_3;


parameter IDLE = 3'b000;
parameter GNT_0 = 3'b001;
parameter GNT_1 = 3'b010;
parameter GNT_2 = 3'b011;
parameter GNT_3 = 3'b100;

reg [2:0] present_state;
reg [2:0] next_state;

always @(posedge clk) begin
	if(rst) begin
		gnt_0 <= 0;
		gnt_1 <= 0;
		gnt_2 <= 0;
		gnt_3 <= 0;
		present_state <= IDLE;
	end
	else begin
		present_state <= next_state;

		case(present_state) 

			IDLE:	begin
						gnt_0 <= 1'b0;
						gnt_1 <= 1'b0;
						gnt_2 <= 1'b0;
						gnt_3 <= 1'b0;
					end

			GNT_0:	begin
						gnt_0 <= 1'b1;
					end	

			GNT_1:	begin
						gnt_1 <= 1'b1;
					end	

			GNT_2:	begin
						gnt_2 <= 1'b1;
					end	

			GNT_3:	begin
						gnt_3 <= 1'b1;
					end	

			default:	begin
							present_state <= IDLE;
						end
		endcase
	end
end

always @(present_state,req_0,req_1,req_2,req_3) begin
	next_state = 0;

	case(present_state)

		IDLE:	if(req_0 == 3'b1) begin
					next_state = GNT_0;
				end
				else if(req_1 == 3'b1) begin
					next_state = GNT_1;
				end
				else if(req_2 == 3'b1) begin
					next_state = GNT_2;
				end
				else if(req_3 == 3'b1) begin
					next_state = GNT_3;
				end
				else begin
					 next_state = IDLE;
				end

		GNT_0:	if(req_0 == 3'b0) begin
					next_state = IDLE;
				end
				else begin
					next_state = GNT_0;
				end

		GNT_1:	if(req_1 == 3'b0) begin
					next_state = IDLE;
				end
				else begin
					next_state = GNT_1;
				end

		GNT_2:	if(req_2 == 3'b0) begin
					next_state = IDLE;
				end
				else begin
					next_state = GNT_2;
				end

		GNT_3:	if(req_3 == 3'b0) begin
					next_state = IDLE;
				end
				else begin
					next_state = GNT_3;
				end

		default:	next_state = IDLE;

	endcase
end

endmodule

