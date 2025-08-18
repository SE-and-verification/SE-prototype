`define SE_DEPTH 4

module fifo_single_read #(
    parameter integer DEPTH = `SE_DEPTH,   // power of two
    parameter integer WIDTH = 8
)(
    input  wire                  clk,
    input  wire                  rst,        // synchronous reset (active high)

    // enqueue (write)
    input  wire                  push,
    input  wire [WIDTH-1:0]      din,

    // dequeue (read)
    input  wire                  pop,
    output reg  [WIDTH-1:0]      dout,

    // status
    output wire                  full,
    output wire                  empty,
    output wire [($clog2(DEPTH)):0] level,  // number of stored items

    // head, tail
    output wire [$clog2(DEPTH)-1:0] head,  // index of next item to read

    // absolute read port
    input  wire [$clog2(DEPTH)-1:0] read_addr,  // 0..DEPTH-1 (physical slot)
    output wire [WIDTH-1:0]         read_data,  // mem[read_addr]
    output wire                     read_valid  // 1 if slot currently occupied
);

    localparam AW = $clog2(DEPTH);

    // Storage
    reg [WIDTH-1:0] mem [0:DEPTH-1];

    // Pointers with extra MSB (phase bit) for full/empty detection
    reg [AW:0] wr_ptr;  // {phase, index}
    reg [AW:0] rd_ptr;

    // =========================
    // Write path
    // =========================
    always @(posedge clk) begin
        if (rst) begin
            wr_ptr <= { (AW+1){1'b0} };
        end else if (push && !full) begin
            mem[wr_ptr[AW-1:0]] <= din;
            wr_ptr <= wr_ptr + 1'b1;
        end
    end

    // =========================
    // Read path
    // =========================
    always @(posedge clk) begin
        if (rst) begin
            rd_ptr <= { (AW+1){1'b0} };
            dout   <= { WIDTH{1'b0} };
        end else if (pop && !empty) begin
            dout   <= mem[rd_ptr[AW-1:0]];
            rd_ptr <= rd_ptr + 1'b1;
        end
    end

    // =========================
    // Status
    // =========================
    assign empty = (wr_ptr == rd_ptr);

    // Full when phases differ and indices equal
    assign full  = (wr_ptr[AW]     != rd_ptr[AW]) &&
                   (wr_ptr[AW-1:0] == rd_ptr[AW-1:0]);

    // Number of valid entries in FIFO
    assign level = wr_ptr - rd_ptr; // width AW+1

    // =========================
    // Absolute read port
    //   read_data  = mem[read_addr] (combinational)
    //   read_valid = 1 iff read_addr currently holds an enqueued element
    //
    //   Test for occupancy (power-of-two DEPTH):
    //     offset = (read_addr - rd_idx) mod DEPTH
    //     read_valid = (offset < level)
    // =========================
    wire [AW-1:0] rd_idx   = rd_ptr[AW-1:0];
    wire [AW-1:0] diff     = (read_addr - rd_idx) & (DEPTH-1); // modulo DEPTH
    assign        read_valid = (diff < level);                 // compares AW+1 vs AW -> zero-extends diff
    assign        read_data  = mem[read_addr];

    assign head = rd_ptr[AW-1:0];  // index of next item to read
    assign tail = wr_ptr[AW-1:0];  // index of next item to write

endmodule

module fifo_double_read #(
    parameter integer DEPTH = `SE_DEPTH,   // power of two
    parameter integer WIDTH = 8
)(
    input  wire                  clk,
    input  wire                  rst,        // synchronous reset (active high)

    // enqueue (write)
    input  wire                  push,
    input  wire [WIDTH-1:0]      din,

    // dequeue (read)
    input  wire                  pop,
    output reg  [WIDTH-1:0]      dout,

    // status
    output wire                  full,
    output wire                  empty,
    output wire [($clog2(DEPTH)):0] level,  // number of stored items

    // head, tail
    output wire [$clog2(DEPTH)-1:0] head,  // index of next item to read

    // absolute read port
    input  wire [$clog2(DEPTH)-1:0] read_addr_1,  // 0..DEPTH-1 (physical slot)
    output wire [WIDTH-1:0]         read_data_1,  // mem[read_addr]
    output wire                     read_valid_1,  // 1 if slot currently occupied

    // absolute read port
    input  wire [$clog2(DEPTH)-1:0] read_addr_2,  // 0..DEPTH-1 (physical slot)
    output wire [WIDTH-1:0]         read_data_2,  // mem[read_addr]
    output wire                     read_valid_2  // 1 if slot currently occupied
);

    localparam AW = $clog2(DEPTH);

    // Storage
    reg [WIDTH-1:0] mem [0:DEPTH-1];

    // Pointers with extra MSB (phase bit) for full/empty detection
    reg [AW:0] wr_ptr;  // {phase, index}
    reg [AW:0] rd_ptr;

    // =========================
    // Write path
    // =========================
    always @(posedge clk) begin
        if (rst) begin
            wr_ptr <= { (AW+1){1'b0} };
        end else if (push && !full) begin
            mem[wr_ptr[AW-1:0]] <= din;
            wr_ptr <= wr_ptr + 1'b1;
        end
    end

    // =========================
    // Read path
    // =========================
    always @(posedge clk) begin
        if (rst) begin
            rd_ptr <= { (AW+1){1'b0} };
            dout   <= { WIDTH{1'b0} };
        end else if (pop && !empty) begin
            dout   <= mem[rd_ptr[AW-1:0]];
            rd_ptr <= rd_ptr + 1'b1;
        end
    end

    // =========================
    // Status
    // =========================
    assign empty = (wr_ptr == rd_ptr);

    // Full when phases differ and indices equal
    assign full  = (wr_ptr[AW]     != rd_ptr[AW]) &&
                   (wr_ptr[AW-1:0] == rd_ptr[AW-1:0]);

    // Number of valid entries in FIFO
    assign level = wr_ptr - rd_ptr; // width AW+1

    // =========================
    // Absolute read port
    //   read_data  = mem[read_addr] (combinational)
    //   read_valid = 1 iff read_addr currently holds an enqueued element
    //
    //   Test for occupancy (power-of-two DEPTH):
    //     offset = (read_addr - rd_idx) mod DEPTH
    //     read_valid = (offset < level)
    // =========================
    wire [AW-1:0] rd_idx_1   = rd_ptr[AW-1:0];
    wire [AW-1:0] diff_1     = (read_addr_1 - rd_idx_1) & (DEPTH-1); // modulo DEPTH
    assign        read_valid_1 = (diff_1 < level);                 // compares AW+1 vs AW -> zero-extends diff
    assign        read_data_1  = mem[read_addr_1];

    wire [AW-1:0] rd_idx_2   = rd_ptr[AW-1:0];
    wire [AW-1:0] diff_2     = (read_addr_2 - rd_idx_2) & (DEPTH-1); // modulo DEPTH
    assign        read_valid_2 = (diff_2 < level);                 // compares AW+1 vs AW -> zero-extends diff
    assign        read_data_2  = mem[read_addr_2];

    assign head = rd_ptr[AW-1:0];  // index of next item to read
    assign tail = wr_ptr[AW-1:0];  // index of next item to write

endmodule

module fifo_seven_read #(
    parameter integer DEPTH = `SE_DEPTH,   // power of two
    parameter integer WIDTH = 8
)(
    input  wire                  clk,
    input  wire                  rst,        // synchronous reset (active high)

    // enqueue (write)
    input  wire                  push,
    input  wire [WIDTH-1:0]      din,

    // dequeue (read)
    input  wire                  pop,
    output reg  [WIDTH-1:0]      dout,

    // status
    output wire                  full,
    output wire                  empty,
    output wire [($clog2(DEPTH)):0] level,  // number of stored items

    // head, tail
    output wire [$clog2(DEPTH)-1:0] head,  // index of next item to read
    output wire [$clog2(DEPTH)-1:0] tail,  // index of next item to write

    // absolute read port 1
    input  wire [$clog2(DEPTH)-1:0] read_addr_1,  // 0..DEPTH-1 (physical slot)
    output wire [WIDTH-1:0]         read_data_1,  // mem[read_addr]
    output wire                     read_valid_1,  // 1 if slot currently occupied

    // absolute read port 2
    input  wire [$clog2(DEPTH)-1:0] read_addr_2,  // 0..DEPTH-1 (physical slot)
    output wire [WIDTH-1:0]         read_data_2,  // mem[read_addr]
    output wire                     read_valid_2,  // 1 if slot currently occupied

    // absolute read port 3
    input  wire [$clog2(DEPTH)-1:0] read_addr_3,  // 0..DEPTH-1 (physical slot)
    output wire [WIDTH-1:0]         read_data_3,  // mem[read_addr]
    output wire                     read_valid_3,  // 1 if slot currently occupied

    // absolute read port 4
    input  wire [$clog2(DEPTH)-1:0] read_addr_4,  // 0..DEPTH-1 (physical slot)
    output wire [WIDTH-1:0]         read_data_4,  // mem[read_addr]
    output wire                     read_valid_4,  // 1 if slot currently occupied

    // absolute read port 5
    input  wire [$clog2(DEPTH)-1:0] read_addr_5,  // 0..DEPTH-1 (physical slot)
    output wire [WIDTH-1:0]         read_data_5,  // mem[read_addr]
    output wire                     read_valid_5,  // 1 if slot currently occupied

    // absolute read port 6
    input  wire [$clog2(DEPTH)-1:0] read_addr_6,  // 0..DEPTH-1 (physical slot)
    output wire [WIDTH-1:0]         read_data_6,  // mem[read_addr]
    output wire                     read_valid_6,  // 1 if slot currently occupied

    // absolute read port 7
    input  wire [$clog2(DEPTH)-1:0] read_addr_7,  // 0..DEPTH-1 (physical slot)
    output wire [WIDTH-1:0]         read_data_7,  // mem[read_addr]
    output wire                     read_valid_7  // 1 if slot currently occupied
);

    localparam AW = $clog2(DEPTH);

    // Storage
    reg [WIDTH-1:0] mem [0:DEPTH-1];

    // Pointers with extra MSB (phase bit) for full/empty detection
    reg [AW:0] wr_ptr;  // {phase, index}
    reg [AW:0] rd_ptr;

    // =========================
    // Write path
    // =========================
    always @(posedge clk) begin
        if (rst) begin
            wr_ptr <= { (AW+1){1'b0} };
        end else if (push && !full) begin
            mem[wr_ptr[AW-1:0]] <= din;
            wr_ptr <= wr_ptr + 1'b1;
        end
    end

    // =========================
    // Read path
    // =========================
    always @(posedge clk) begin
        if (rst) begin
            rd_ptr <= { (AW+1){1'b0} };
            dout   <= { WIDTH{1'b0} };
        end else if (pop && !empty) begin
            dout   <= mem[rd_ptr[AW-1:0]];
            rd_ptr <= rd_ptr + 1'b1;
        end
    end

    // =========================
    // Status
    // =========================
    assign empty = (wr_ptr == rd_ptr);

    // Full when phases differ and indices equal
    assign full  = (wr_ptr[AW]     != rd_ptr[AW]) &&
                   (wr_ptr[AW-1:0] == rd_ptr[AW-1:0]);

    // Number of valid entries in FIFO
    assign level = wr_ptr - rd_ptr; // width AW+1

    assign head = rd_ptr[AW-1:0];  // index of next item to read
    assign tail = wr_ptr[AW-1:0];  // index of next item to write

    // =========================
    // Absolute read port
    //   read_data  = mem[read_addr] (combinational)
    //   read_valid = 1 iff read_addr currently holds an enqueued element
    //
    //   Test for occupancy (power-of-two DEPTH):
    //     offset = (read_addr - rd_idx) mod DEPTH
    //     read_valid = (offset < level)
    // =========================
    wire [AW-1:0] rd_idx_1   = rd_ptr[AW-1:0];
    wire [AW-1:0] diff_1     = (read_addr_1 - rd_idx_1) & (DEPTH-1); // modulo DEPTH
    assign        read_valid_1 = (diff_1 < level);                 // compares AW+1 vs AW -> zero-extends diff
    assign        read_data_1  = mem[read_addr_1];

    wire [AW-1:0] rd_idx_2   = rd_ptr[AW-1:0];
    wire [AW-1:0] diff_2     = (read_addr_2 - rd_idx_2) & (DEPTH-1); // modulo DEPTH
    assign        read_valid_2 = (diff_2 < level);                 // compares AW+1 vs AW -> zero-extends diff
    assign        read_data_2  = mem[read_addr_2];

    wire [AW-1:0] rd_idx_3   = rd_ptr[AW-1:0];
    wire [AW-1:0] diff_3     = (read_addr_3 - rd_idx_3) & (DEPTH-1); // modulo DEPTH
    assign        read_valid_3 = (diff_3 < level);                 // compares AW+1 vs AW -> zero-extends diff
    assign        read_data_3  = mem[read_addr_3];


    wire [AW-1:0] rd_idx_4   = rd_ptr[AW-1:0];
    wire [AW-1:0] diff_4     = (read_addr_4 - rd_idx_4) & (DEPTH-1); // modulo DEPTH
    assign        read_valid_4 = (diff_4 < level);                 // compares AW+1 vs AW -> zero-extends diff
    assign        read_data_4  = mem[read_addr_4];

    wire [AW-1:0] rd_idx_5   = rd_ptr[AW-1:0];
    wire [AW-1:0] diff_5     = (read_addr_5 - rd_idx_5) & (DEPTH-1); // modulo DEPTH
    assign        read_valid_5 = (diff_5 < level);                 // compares AW+1 vs AW -> zero-extends diff
    assign        read_data_5  = mem[read_addr_5];

    wire [AW-1:0] rd_idx_6   = rd_ptr[AW-1:0];
    wire [AW-1:0] diff_6     = (read_addr_6 - rd_idx_6) & (DEPTH-1); // modulo DEPTH
    assign        read_valid_6 = (diff_6 < level);                 // compares AW+1 vs AW -> zero-extends diff
    assign        read_data_6  = mem[read_addr_6];

    wire [AW-1:0] rd_idx_7   = rd_ptr[AW-1:0];
    wire [AW-1:0] diff_7     = (read_addr_7 - rd_idx_7) & (DEPTH-1); // modulo DEPTH
    assign        read_valid_7 = (diff_7 < level);                 // compares AW+1 vs AW -> zero-extends diff
    assign        read_data_7  = mem[read_addr_7];

endmodule