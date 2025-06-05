module fifo #(parameter WIDTH = 8, parameter DEPTH = 3) (
    input                   clk,
    input                   rst,
    input                   wr_en,   // Write enable
    input                   rd_en,   // Read enable
    input  [WIDTH-1:0]      data_in, // Data to be written
    output reg [WIDTH-1:0]  data_out,// Data read
    output                  full,    // FIFO full flag
    output                  empty    // FIFO empty flag
);

    // Calculate address width based on depth
    localparam ADDR_WIDTH = $clog2(DEPTH);

    // FIFO memory
    reg [WIDTH-1:0] mem [0:DEPTH-1];
    
    // Read and write pointers
    reg [ADDR_WIDTH:0] wr_ptr; // Write pointer
    reg [ADDR_WIDTH:0] rd_ptr; // Read pointer
    reg [ADDR_WIDTH:0] count;  // Tracks the number of elements in FIFO

    wire full, empty; // Flags

    // FIFO logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            count <= 0;
            data_out <= 0;
        end else begin
            // Write operation
            if (wr_en && !full) begin
                mem[wr_ptr[ADDR_WIDTH-1:0]] <= data_in;
                wr_ptr <= wr_ptr + 1;
                count <= count + 1;
            end
            
            // Read operation
            if (rd_en && !empty) begin
                data_out <= mem[rd_ptr[ADDR_WIDTH-1:0]];
                rd_ptr <= rd_ptr + 1;
                count <= count - 1;
            end

        end
    end

    assign full = (count == DEPTH);
    assign empty = (count == 0);
endmodule