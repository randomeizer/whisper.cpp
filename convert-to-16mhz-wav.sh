#!/bin/bash

# This script uses ffmpeg to convert audio files into 16 kHz WAV files for use with this library.

input=$1

if [ "$#" -ne 1 ]; then
    printf "Usage: $0 <input>\n"
    printf "  input: path to audio file\n"
    exit 1
fi

inputFile=$(basename "$input")
inputPath=$(dirname "$input")
inputWithoutExtension="${inputFile%.*}"
outputFile="$inputWithoutExtension-16kHz.wav"
output="$inputPath/$outputFile"

if [ -f "$output" ]; then
    printf "Output file already exists: $output\n"
    exit 1
fi

printf "Converting $inputFile to $outputFile ...\n"

ffmpeg -loglevel -0 -y -i "$input" -ar 16000 -ac 1 -c:a pcm_s16le "$output"

printf "Done! Converted file saved in '$output'\n"
printf "You can now use it like this:\n\n"
printf "  $ ./main -m models/ggml-base.en.bin -f $output\n"
printf "\n"