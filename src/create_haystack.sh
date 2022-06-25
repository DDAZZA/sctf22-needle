#!/bin/bash


for run in {1..600}; do
  file="haystack/straw$RANDOM.txt"
  tr -dc A-Za-z0-9 </dev/urandom | head -c 512 > "$file"
done


file="haystack/straw$RANDOM.txt"
tr -dc A-Za-z0-9 </dev/urandom | head -c 256 > "$file"
echo "NEEDLE\nUse the base32 program to decode the following\nKRUGKIDGNRQWOIDJOMQFGQ2UIYZDE63MNFXHK6C7MJAWSY3TPU======" >> $file

echo "Flag written to $file"
