module moore_machine(
    input clk,
    input reset,
    input in,
    output reg out
);
    typedef enum reg [1:0] { s0 = 2'b00, s1 = 2'b01, s2 = 2'b10, s3 = 2'b11 } state_t;
    state_t current_state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= s0;
        else
            current_state <= next_state;
    end
    always @(*) begin
      case (current_state)
          s0: next_state = (in) ? s0 : s1; 
          s1: next_state = (in) ? s2 : s1; 
          s2: next_state = (in) ? s0 : s3; 
          s3: next_state = (in) ? s2 : s1; 
          default: next_state = s0;
      endcase
	end
    always @(*) begin
        case (current_state)
            s0, s1, s2: out = 0;
            s3: out = 1;
            default: out = 0;
        endcase
    end
endmodule
