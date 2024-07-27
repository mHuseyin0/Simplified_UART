#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2021.1 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Thu May 02 22:09:34 +03 2024
# SW Build 3247384 on Thu Jun 10 19:36:07 MDT 2021
#
# IP Build 3246043 on Fri Jun 11 00:30:35 MDT 2021
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# simulate design
echo "xsim Register_Sim_behav -key {Behavioral:Register_Sim:Functional:Register_Sim} -tclbatch Register_Sim.tcl -log simulate.log"
xsim Register_Sim_behav -key {Behavioral:Register_Sim:Functional:Register_Sim} -tclbatch Register_Sim.tcl -log simulate.log
