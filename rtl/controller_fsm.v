module controller_fsm #(
    parameter WIDTH = 32,
parameter COUNT_WIDTH = 6
)(
    input  wire                   clk,
    input  wire                   rst,
    input  wire                   start,
    input  wire [COUNT_WIDTH-1:0] count,
    output reg                    load,
    output reg                    enable,
    output reg                    done
);

    reg [1:0] state;

    localparam IDLE = 2'b00,
               LOAD = 2'b01,
               RUN  = 2'b10,
               DONE = 2'b11;

    // State register
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else begin
            case (state)
                IDLE: if (start) state <= LOAD;
                LOAD:            state <= RUN;
                RUN : if (count >= WIDTH) state <= DONE;
                DONE:            state <= IDLE;
                default:         state <= IDLE;
            endcase
        end
    end

    // Output logic
    always @(*) begin
        load   = 1'b0;
        enable = 1'b0;
        done   = 1'b0;

        case (state)
            LOAD: load   = 1'b1;
            RUN : enable = 1'b1;
            DONE: done   = 1'b1;
            default: ;
        endcase
    end

endmodule
