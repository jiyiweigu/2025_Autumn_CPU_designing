module minicpu_top(
    input  wire        clk,
    input  wire        resetn,

    output wire        inst_sram_we,
    output wire [31:0] inst_sram_addr,
    output wire [31:0] inst_sram_wdata,
    input  wire [31:0] inst_sram_rdata,

    output wire        data_sram_we,
    output wire [31:0] data_sram_addr,
    output wire [31:0] data_sram_wdata,
    input  wire [31:0] data_sram_rdata
);
// 接口已经为你准备好，请在此补充你的CPU设计

endmodule
                         