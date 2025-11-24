#!/bin/bash
input="$1"
output="$2"

awk 'BEGIN {OFS=","} 
     {for(i=1;i<=NF;i++) printf "%s%s", $i, (i==NF ? "\n" : OFS)}' FS='\t' "$input" > "$output"

