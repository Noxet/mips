onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mini_mips_tb/uut/if_top_inst/clk
add wave -noupdate /mini_mips_tb/uut/if_top_inst/rst_n
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {121000 ps} 0}
configure wave -namecolwidth 163
configure wave -valuecolwidth 114
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1018773 ps}
