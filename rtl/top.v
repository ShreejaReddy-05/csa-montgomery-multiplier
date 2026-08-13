module top #(
   parameter WIDTH = 32,
parameter COUNT_WIDTH = 6
)(
    input  wire             clk,
    input  wire             rst,
    input  wire             start,
    input  wire [WIDTH-1:0] A,
    input  wire [WIDTH-1:0] B,
    input  wire [WIDTH-1:0] N,
    output wire [WIDTH-1:0] Z,
    output wire             done
);

    wire load;
    wire enable;
    wire [COUNT_WIDTH-1:0] count;

    // Controller FSM
    controller_fsm #(
        .WIDTH(WIDTH)
    ) u_fsm (
        .clk(clk),
        .rst(rst),
        .start(start),
        .count(count),
        .load(load),
        .enable(enable),
        .done(done)
    );

    // Datapath
    datapath #(
        .WIDTH(WIDTH)
    ) u_dp (
        .clk(clk),
        .load(load),
        .enable(enable),
        .A(A),
        .B(B),
        .N(N),
        .Z(Z),
        .count(count)
    );

endmodule
