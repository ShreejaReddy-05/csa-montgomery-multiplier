`timescale 1ns/1ps

module tb_top;

    parameter WIDTH = 32;

    reg                  clk;
    reg                  rst;
    reg                  start;
    reg  [WIDTH-1:0]     A;
    reg  [WIDTH-1:0]     B;
    reg  [WIDTH-1:0]     N;

    wire [WIDTH-1:0]     Z;
    wire                 done;

    // DUT
    top #(
        .WIDTH(WIDTH)
    ) dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .A(A),
        .B(B),
        .N(N),
        .Z(Z),
        .done(done)
    );

    // Clock generation (10 ns period)
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Task to run one test
    task run_test;
        input [WIDTH-1:0] a_in;
        input [WIDTH-1:0] b_in;
        input [WIDTH-1:0] n_in;
        begin
            @(negedge clk);
            A     = a_in;
            B     = b_in;
            N     = n_in;
            start = 1'b1;

            @(negedge clk);
            start = 1'b0;

            // Wait until done becomes high
            wait(done == 1'b1);

            $display("A=%0d B=%0d N=%0d -> Z=%0d at time %0t",
                     A, B, N, Z, $time);

            @(negedge clk);
        end
    endtask

    // Test sequence
    initial begin
        rst   = 1'b1;
        start = 1'b0;
        A     = 0;
        B     = 0;
        N     = 0;

        #20;
        rst = 1'b0;

        // N must be odd
        run_test(5,      3,      7);
        run_test(9,      4,      11);
        run_test(12345,  6789,   65537);

        #50;
        $finish;
    end

endmodule
