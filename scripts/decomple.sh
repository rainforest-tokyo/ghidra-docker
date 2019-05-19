#!/bin/bash
rm -rf /home/ghidra/tmp/*
cd /opt/ghidra/
./support/analyzeHeadless /home/ghidra/tmp/ "IoTMalware" -import /home/ghidra/target -postScript /home/ghidra/Decompile2.java /home/ghidra/result
