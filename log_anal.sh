#!/bin/bash +x

total=`zcat $1 |wc -l | awk '{print $1}'`

vals=($total)

if [ -n "$2" ]; then
    zcat $1 | awk -f log_anal.awk -vvals="${vals[*]}" | awk -f log_anal_by_time.awk -vvals="$2"
else
    zcat $1 | awk -f log_anal.awk -vvals="${vals[*]}"
fi