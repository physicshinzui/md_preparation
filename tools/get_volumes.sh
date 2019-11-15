#!/bin/bash
set -Ceu

cat << EOF

usage
    bash $0 [out log file of NPT]

EOF

grep VOLUME $1 | awk '{print $4}' > volume.dat
