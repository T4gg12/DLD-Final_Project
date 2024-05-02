# Copyright 1991-2016 Mentor Graphics Corporation
# 
# Modification by Oklahoma State University
# Use with Testbench 
# James Stine, 2008
# Go Cowboys!!!!!!
#
# All Rights Reserved.
#
# THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY INFORMATION
# WHICH IS THE PROPERTY OF MENTOR GRAPHICS CORPORATION
# OR ITS LICENSORS AND IS SUBJECT TO LICENSE TERMS.

# Use this run.do file to run this example.
# Either bring up ModelSim and type the following at the "ModelSim>" prompt:
#     do run.do
# or, to run from a shell, type the following at the shell prompt:
#     vsim -do run.do -c
# (omit the "-c" to see the GUI while running from the shell)

onbreak {resume}

# create library
if [file exists work] {
    vdel -all
}
vlib work

# compile source files
vlog fsm.sv fsm_tb.sv

# start and run simulation
vsim -voptargs=+acc work.fsm_tb

view list
view wave

-- display input and output signals as hexidecimal values
# Diplays All Signals recursively
add wave -noupdate -divider -height 32 "FSM"
add wave -hex /fsm_tb/dut/*
# add wave -hex /fsm_tb/dut/y
# add wave -hex /fsm_tb/dut/reset
# add wave -hex /fsm_tb/dut/clk
# add wave -hex /fsm_tb/dut/switch1
# add wave -hex /fsm_tb/dut/switch2
# add wave -hex /fsm_tb/dut/seed
# add wave -hex /fsm_tb/dut/out


add list -hex -r /fsm_tb/*
add log -r /*

-- Set Wave Output Items 
TreeUpdate [SetDefaultTree]
WaveRestoreZoom {0 ps} {75 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2

-- Run the Simulation
run 180 ns