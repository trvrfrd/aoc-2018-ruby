#!/usr/bin/env ruby

# solutions to part 1 and 2 of:
# https://adventofcode.com/2018/day/1

################
# begin part 1 #
################

# make sure we get the path relative to the running script (this file)
# otherwise if we're executing the script from project_root/ vs project_root/1/
# we'll get different paths and everything will explode
input_path = File.expand_path("input.txt", File.dirname(__FILE__))
frequency_changes = File.read(input_path).split("\n").map(&:to_i)
initial_frequency = 0

resulting_frequency = frequency_changes.sum initial_frequency

puts "Day 1 Part 1 solution:", resulting_frequency


################
# begin part 2 #
################

require "set"

frequencies_reached = Set.new
frequencies_reached.add(initial_frequency)

# this could run forever but the puzzle seems to guarantee a repeat frequency
frequency_changes.cycle.reduce(initial_frequency) do |current_frequency, change|
  current_frequency += change
  if frequencies_reached.include?(current_frequency)
    puts "Day 1 Part 2 solution:", current_frequency
    break
  end
  frequencies_reached.add(current_frequency)
  current_frequency
end
