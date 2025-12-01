#!/bin/env bash

input=$1

dial=50
zeros=0

for line in $(cat $1); do
    if [[ $line =~ ^([LR])([0-9]+)$ ]] then
        case ${BASH_REMATCH[1]} in
            L)
                dial=$(($dial-${BASH_REMATCH[2]}))
                ;;
            R)
                dial=$(($dial+${BASH_REMATCH[2]}))
                ;;
        esac
        if (( dial % 100 == 0)) then
            zeros=$(($zeros+1))
        fi
    fi
done

echo $zeros

