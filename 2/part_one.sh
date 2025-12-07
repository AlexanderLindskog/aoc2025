#!/bin/env bash

file=$1

IFS=',' read -ra ranges < "$file"

for range in ${ranges[@]}; do
    IFS='-' read -r low high <<< "$range"
    printf '['
    for ((i=$low;i<=$high;i++)); do
        if [[ $i =~ (\w+)\1+ ]]; then
            printf " $BASH_REMATCH[1] "
        fi
    done
    printf ']\n'
done

