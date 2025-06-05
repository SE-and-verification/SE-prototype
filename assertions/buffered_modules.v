// Auto-generated Verilog file

module module_name_1_buffer (
    input clk,
    input write_en,
    input [15:0] signal_x,
    output [15:0] signal_x_buffered,
    input [7:0] signal_y,
    output [7:0] signal_y_buffered,
);

    reg [15:0] signal_x_buffered;
    reg [15:0]  signal_x_mem [0:2];
    reg [7:0] signal_y_buffered;
    reg [7:0]  signal_y_mem [0:2];
    reg [$clog2(3)-1:0] write_ptr = 0;

    always @(posedge clk) begin
        if (write_en) begin
            signal_x_mem[write_ptr] <= signal_x;
            signal_y_mem[write_ptr] <= signal_y;
            write_ptr <= write_ptr + 1;
        end
    end

    assign signal_x_buffered = signal_x_mem[write_ptr];
    assign signal_y_buffered = signal_y_mem[write_ptr];
endmodule

module module_name_2_buffer (
    input clk,
    input write_en,
    input [31:0] signal_z,
    output [31:0] signal_z_buffered,
);

    reg [31:0] signal_z_buffered;
    reg [31:0]  signal_z_mem [0:2];
    reg [$clog2(3)-1:0] write_ptr = 0;

    always @(posedge clk) begin
        if (write_en) begin
            signal_z_mem[write_ptr] <= signal_z;
            write_ptr <= write_ptr + 1;
        end
    end

    assign signal_z_buffered = signal_z_mem[write_ptr];
endmodule

