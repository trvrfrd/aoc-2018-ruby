#!/usr/bin/env sh
# makes a new directory and starter solution file for an AoC day

if [ $# -eq 0 ]; then
  echo "Usage: $0 day_number"
  exit 1
fi

# this won't do anything if the dir already exists, and that's great
# we'll just tell them below that a file already exists
mkdir "$1" 2> /dev/null

if [ ! -f $1/solutions.rb ]; then
  echo "creating solutions template for day $1..."
  head -8 1/solutions.rb | sed "s/day\/1/day\/$1/" > $1/solutions.rb
  chmod +x $1/solutions.rb

  echo "you will need to manually download the puzzle input here:"
  echo "https://adventofcode.com/2018/day/$1/input"
  echo "~*good luck!*~"
  exit 0
else
  echo "solutions file already exists for day $1; aborting..."
  exit 1
fi
