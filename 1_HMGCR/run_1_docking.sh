#!/bin/bash

echo "Running protonation"
bash 1_protonation/protonation.sh

echo "Running docking"
bash 2_docking/docking.sh

echo "Done"
