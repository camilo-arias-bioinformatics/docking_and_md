#!/bin/bash

cd ../3_molecular_dynamics

# generate topology
gmx pdb2gmx -f ../1_protonation/protein_protonated.pdb -o protein_processed.gro -p protein.top -i posre.itp -ff amber99sb-ildn -water tip3p

# set cofactor parameters
grep -w "A 101" ../molecules/cofactor.pdb > ADP1.pdb
time conda run -n ambertools_env antechamber -i ADP1.pdb -fi pdb -o ADP_single.mol2 -fo mol2 -c bcc -at gaff2 -nc -3
conda run -n ambertools_env parmchk2 -i ADP_single.mol2 -f mol2 -o ADP_single.frcmod
conda run -n ambertools_env acpype -i ADP_single.mol2 -b ADP
cp ADP.acpype/ADP_GMX.itp .
cp ADP.acpype/ADP_GMX.gro .
sed -i '/#include "ADP_GMX.itp"/d' protein.top
sed -i '/#include "amber99sb-ildn.ff\/forcefield.itp"/a #include "ADP_GMX.itp"' protein.top
gmx editconf -f ADP1.pdb -o ADP1.gro

# select model for water and process crystallographic water molecules
gmx pdb2gmx -f ../molecules/water_molecules.pdb -o hoh_crystal.gro -p hoh.top -ff amber99sb-ildn -water tip3p
