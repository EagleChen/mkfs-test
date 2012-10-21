#!/bin/bash
set -x
set -e
result=result.csv
for i in 1 2 5 10
do
  for j in 3072 10240 20480
  do
    call_cmd_file  $i $j $result
    echo >> $result
  done
done

call_cmd_file () {
  umount -d mounts/*
  rm -rf *.img
  rm -rf mounts/*
  rm -rf logs/*
  
  iostat -x 1 > logs/$1_$2.log &
  sleep 1
  
  for(( i=1; i <= $1; i++)) 
  do
    ./test_mkfs.sh $i $2 $3 &
  done
  
  for(( i=2; i <= $1+1; i++)) 
  do
    wait %$i
  done
  
  sleep 1
  pkill iostat
}
