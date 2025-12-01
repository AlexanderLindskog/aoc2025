#!/bin/env bash

file=$1

dial=50
zeros=0
was_zero=0

while IFS= read -r line; do
    if [[ $line =~ ^([LR])([0-9]+)$ ]] then
        case ${BASH_REMATCH[1]} in
            L)
                dial=$(($dial-${BASH_REMATCH[2]}))
                zeros=$((zeros-dial/100))
                if (( (dial < 0 && was_zero == 0) || dial == 0 )) then
                    zeros=$((zeros+1))
                fi
                dial=$((dial%100))
                if (( dial < 0 )) then
                    dial=$((dial+100))
                fi
                ;;
            R)
                dial=$(($dial+${BASH_REMATCH[2]}))
                zeros=$((zeros+dial/100))
                dial=$((dial%100))
                ;;
        esac
        was_zero=$((dial==0))
    fi
done < "$file"

echo $zeros

