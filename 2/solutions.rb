#!/usr/bin/env ruby

# solutions to part 1 and 2 of:
# https://adventofcode.com/2018/day/2

################
# begin part 1 #
################

class BoxID
  attr_reader :id

  def initialize id_str
    @id = id_str
  end

  def letter_counts
    return @counts if @counts

    @counts = Hash.new(0)
    id.each_char { |c| @counts[c] += 1 }
    @counts
  end

  def letter_repeated_n_times? n
    letter_counts.values.any? { |count| count == n }
  end
end

input_path = File.expand_path("input.txt", File.dirname(__FILE__))
box_ids = File.read(input_path).split("\n").map { |id_str| BoxID.new id_str }

double_letter_count = 0
triple_letter_count = 0

box_ids.each do |id|
  double_letter_count += 1 if id.letter_repeated_n_times? 2
  triple_letter_count += 1 if id.letter_repeated_n_times? 3
end

checksum = double_letter_count * triple_letter_count

# part 1 solution
puts "Day 2 Part 1 solution:", checksum


################
# begin part 2 #
################
