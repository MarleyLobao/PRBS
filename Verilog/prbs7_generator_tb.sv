`include "Verilog/prbs_generator.v"

module prbs7_generator_tb;

logic clock_tb;
logic init_tb;
logic [3:0] prbs_type_tb;
logic [31:0] out_tb;

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

  @(posedge clock_tb);
  init_tb = 1;

  repeat(2) @(posedge clock_tb);
  init_tb = 0;

  repeat(128) @(posedge clock_tb);
  $stop;
end

endmodule