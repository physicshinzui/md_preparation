#!/bin/bash
set -eu

grep "POTENTIAL (KCAL/MOL)" em.out | awk '{print $9}' > potential.out
