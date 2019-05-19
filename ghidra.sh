#!/bin/bash

docker exec ghidra mkdir /home/ghidra/tmp
docker exec ghidra mkdir /home/ghidra/result

docker cp scripts/decomple.sh ghidra:/home/ghidra
docker cp scripts/Decompile2.java ghidra:/home/ghidra
docker cp $1 ghidra:/home/ghidra/target

docker exec ghidra /home/ghidra/decomple.sh
docker cp ghidra:/home/ghidra/result.c $2
docker exec ghidra rm -f /home/ghidra/target
docker exec ghidra rm -rf /home/ghidra/tmp
docker exec ghidra rm -rf /home/ghidra/result
docker exec ghidra rm -f /home/ghidra/result.c

