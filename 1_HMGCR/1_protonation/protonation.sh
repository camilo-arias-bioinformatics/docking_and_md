#!/bin/bash

cd 1_protonation

# protonation on the complex
conda run -n ambertools_env pdb2pqr --ff=AMBER --with-ph=7.4 --titration-state-method=propka   --pdb-output=complex_protonated.pdb   ../molecules/protein_cofactor_water_molecules.pdb complex.pqr

# activate virtual environment
source ../../.gitignore/.venv/bin/activate

# extract only protein atoms from the protonated complex
grep -E "^(ATOM|TER|END)" complex_protonated.pdb | awk '{print substr($0,18,3)}' | sort -u > /tmp/resnames.txt
echo "Remember to check complex.txt and make sure only expected residues are listed"
awk '!(substr($0,18,3)=="ADP" || substr($0,18,3)=="HOH")' complex_protonated.pdb > protein_protonated.pdb
propka3 ../molecules/protein_cofactor_water_molecules.pdb
grep -A100 "SUMMARY OF THIS PREDICTION" protein_cofactor_water_molecules.pka | grep -E "ASP|GLU|HIS|LYS|CYS|TYR|ARG" > propka_summary_${sample}.txt
echo "Rerported atoms should be manually inspected"
