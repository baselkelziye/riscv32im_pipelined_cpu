module hazard_detection_unit(
    input clk_i,  // Clock input
    input is_load_instruction,
    input [4:0] rd_label_id_ex_o,
    input [4:0] rs1_label_if_id_o,
    input [4:0] rs2_label_if_id_o,
    
    output reg stall
);

// Temporary register to track hazard condition


initial begin
    stall <= 1'b0;
end

always @(posedge clk_i) begin
    if (is_load_instruction && ((rs1_label_if_id_o == rd_label_id_ex_o) || (rs2_label_if_id_o == rd_label_id_ex_o))) begin
        stall <= 1'b1;
    end
    else begin
        stall <= 1'b0;
    end

    // Set stall for one clock cycle when hazard is detected

end

endmodule
