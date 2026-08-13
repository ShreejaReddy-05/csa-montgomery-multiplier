module datapath #(
    parameter WIDTH = 32,
parameter COUNT_WIDTH = 6
)(
    input  wire                   clk,
    input  wire                   load,
    input  wire                   enable,
    input  wire [WIDTH-1:0]       A,
    input  wire [WIDTH-1:0]       B,
    input  wire [WIDTH-1:0]       N,
    output wire [WIDTH-1:0]       Z,
    output reg  [COUNT_WIDTH-1:0] count
);

    // Registers
    reg  [WIDTH:0]   S;       // WIDTH+1 bits
    reg  [WIDTH-1:0] A_reg;

    // Temporary wires
    wire             Ai;
    wire [WIDTH:0]   temp1;
    wire [WIDTH:0]   temp2;
    wire [WIDTH:0]   next_S;

    // Current LSB of A
    assign Ai = A_reg[0];

    // temp1 = S + (Ai ? B : 0)
    assign temp1 = S + (Ai ? {1'b0, B} : {(WIDTH+1){1'b0}});

    // temp2 = temp1 + (temp1 odd ? N : 0)
    assign temp2 = temp1 + (temp1[0] ? {1'b0, N} : {(WIDTH+1){1'b0}});

    // Divide by 2
    assign next_S = temp2 >> 1;

    // Sequential logic
    always @(posedge clk) begin
        if (load) begin
            S     <= {(WIDTH+1){1'b0}};
            A_reg <= A;
            count <= {COUNT_WIDTH{1'b0}};
        end
        else if (enable) begin
            S     <= next_S;
            A_reg <= A_reg >> 1;
            count <= count + 1'b1;
        end
    end

    // Output
    assign Z = S[WIDTH-1:0];

endmodule
