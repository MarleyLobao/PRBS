`include "prbs_generator.v"

import "DPI-C" context function int prbs7_calc(int seed);

module prbs7_generator_tb;

logic clock_tb;
logic init_tb;
logic [3:0] prbs_type_tb;
logic [31:0] out_tb;

int seed, model_result = 32'hfe041851;
int assert_cnt = 0, errors_cnt = 0;

prbs_generator prbs_generator_inst
(
.clock(clock_tb),
.init(init_tb),
.prbs_type(prbs_type_tb),
.out(out_tb)
);

always #5 clock_tb = ~clock_tb;

initial begin
  clock_tb = 0;
  init_tb = 0;
  prbs_type_tb = 4'b0; // only prbs7

  @(posedge clock_tb); //pulse to initialize
  init_tb = 1;
  @(posedge clock_tb);
  init_tb = 0;
  @(posedge clock_tb);

  repeat(127) begin
    seed = model_result;
    @(posedge clock_tb);
    model_result = prbs7_calc(seed);

    prbs7_assertion: assert (out_tb == model_result) begin
      assert_cnt++;
    end else begin
      errors_cnt++;
      $error("PRBS7 Assertion failed! RTL: %h, Model: %h", out_tb, model_result);
    end
  end

  $display("Assertions passed: %d", assert_cnt);
  $display("Assertions failed: %d", errors_cnt);

  $stop;
end

endmodule