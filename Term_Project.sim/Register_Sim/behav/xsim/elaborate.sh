#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2021.1 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Thu May 02 22:09:32 +03 2024
# SW Build 3247384 on Thu Jun 10 19:36:07 MDT 2021
#
# IP Build 3246043 on Fri Jun 11 00:30:35 MDT 2021
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# elaborate design
echo "xelab -wto fc16d83de4b14d3890103d2240108d3e --incr --debug typical --relax --mt 8 -L xil_defaultlib -L uvm -L unisims_ver -L unimacro_ver -L secureip --snapshot Register_Sim_behav xil_defaultlib.Register_Sim xil_defaultlib.glbl -log elaborate.log"
xelab -wto fc16d83de4b14d3890103d2240108d3e --incr --debug typical --relax --mt 8 -L xil_defaultlib -L uvm -L unisims_ver -L unimacro_ver -L secureip --snapshot Register_Sim_behav xil_defaultlib.Register_Sim xil_defaultlib.glbl -log elaborate.log
