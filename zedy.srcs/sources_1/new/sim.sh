#!/bin/bash
. $MODULESHOME/init/bash
module purge
module load questasim/2021.3_network
mkdir -p simulation
cd simulation

vsim -do "../run.do"
