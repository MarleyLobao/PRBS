vlog -work work prbs7_generator_tb.sv

vsim -sv_lib ../C_model_to_compare/libdpi -voptargs=+acc work.prbs7_generator_tb

add wave sim:/prbs7_generator_tb/*

run 2 us

wave zoom full