#!/bin/bash
set -eu

grep "POTENTIAL (KCAL/MOL)" $1 | awk '{print $9}' > potential.out
