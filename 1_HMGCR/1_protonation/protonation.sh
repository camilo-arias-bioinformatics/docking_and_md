#!/bin/bash

conda run -n ambertools_env pdb2pqr --ff=AMBER --with-ph=7.4 --titration-state-method=propka   --pdb-output=complex_protonated.pdb   ../molecules/protein.pdb complex.pqr

