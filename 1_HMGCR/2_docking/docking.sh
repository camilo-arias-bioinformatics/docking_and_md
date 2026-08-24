#!/bin/bash

cd ../2_docking

# prepare the receptor
mk_prepare_receptor.py -i ../1_protonation/protein_protonated.pdb -o receptor -p

# prepare the ligand
obabel ../molecules/ligand.pdb -O ligand.sdf -h
mk_prepare_ligand.py -i ligand.sdf -o ligand.pdbqt

# create grid box
mk_prepare_receptor.py -i ../1_protonation/protein_protonated.pdb -o grid -v --box_enveloping ../molecules/ligand.pdb --padding=5 && mv grid.box.txt grid.txt

# run docking
vina --receptor receptor.pdbqt --ligand ligand.pdbqt --config grid.txt --out docked.pdbqt > docking.log
echo "Check docking.log to review docking results"
