#!/bin/bash

cd 1_protonation

# protonation on the complex
conda run -n ambertools_env pdb2pqr --ff=AMBER --with-ph=7.4 --titration-state-method=propka   --pdb-output=complex_protonated.pdb   ../molecules/protein_ligand_water_molecules.pdb complex.pqr

# extract only protein atoms from the protonated complex
grep -E "^(ATOM|TER|END)" complex_protonated.pdb | awk '{print substr($0,18,3)}' | sort -u > /tmp/resnames.txt
echo "Remember to check xomplex.txt and make sure only expected residues are listed"
awk '!(substr($0,18,3)=="ADP" || substr($0,18,3)=="HOH")' complex_protonated.pdb > protein_only_protonated.pdb
