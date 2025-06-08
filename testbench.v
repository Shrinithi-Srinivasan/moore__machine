module tb_moore_machine();
    reg clk;
    reg reset;
    reg in;
    wire out;
    moore_machine uut (
        .clk(clk),
        .reset(reset),
        .in(in),
        .out(out)
    );
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end
    initial begin
        $display("Time\tReset\tInput\tState\tOutput");
        $monitor("%0t\t%b\t%b\t%0d\t%b", $time, reset, in, uut.current_state, out);
        reset = 1;
        in = 0;
        #10;
        reset = 0;
        in = 0; #10; // s0 -> s1, output = 0
        in = 1; #10; // s1 -> s2, output = 0
        in = 1; #10; // s2 -> s0, output = 0
        in = 0; #10; // s0 -> s1, output = 0
        in = 1; #10; // s1 -> s2, output = 0
        in = 0; #10; // s2 -> s3, output = 1
        in = 1; #10; // s3 -> s2, output = 0
        in = 0; #10; // s2 -> s3, output = 1
        $finish;
    end
    initial begin
        $dumpfile("moore_machine.vcd");
        $dumpvars(1);
    end
endmodule
