#!/bin/bash

i=$1
file=$(echo $i | cut -d: -f 1)
n=$(echo $i | cut -d: -f 2)

echo $i $file $n

start=$(( $n + 20 ))
end=$(( 23 ))

cat $file | head -n $start | tail -n $end


