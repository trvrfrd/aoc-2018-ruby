#!/usr/bin/env ruby

# solutions to part 1 and 2 of:
# https://adventofcode.com/2018/day/2

################
# begin part 1 #
################

# what if I did things... the OOP way?!
class Box
  attr_reader :id

  def initialize id
    @id = id
  end

  def letter_counts
    return @letter_counts if @letter_counts

    @letter_counts = Hash.new(0)
    id.each_char { |c| @letter_counts[c] += 1 }
    @letter_counts
  end

  def letter_repeated_n_times? n
    letter_counts.values.any? { |count| count == n }
  end

  def differ_by_one_letter? other_box
    differing_letter_counts = 0

    (0...id.length).each do |idx|
      differing_letter_counts += 1 if id[idx] != other_box.id[idx]
      return false if differing_letter_counts > 1
    end

    true
  end

  def letters_in_common_with other_box
    common_letters = id

    (0...id.length).each do |idx|
      if id[idx] != other_box.id[idx]
        # delete spaces later, don't want to mess up the index by deleting now
        common_letters[idx] = " "
        break
      end
    end

    common_letters.gsub " ", ""
  end
end

input_path = File.expand_path("input.txt", File.dirname(__FILE__))
boxes = File.read(input_path).split("\n").map { |id_str| Box.new id_str }

double_letter_count = 0
triple_letter_count = 0

boxes.each do |box|
  double_letter_count += 1 if box.letter_repeated_n_times? 2
  triple_letter_count += 1 if box.letter_repeated_n_times? 3
end

checksum = double_letter_count * triple_letter_count

# part 1 solution
puts "Day 2 Part 1 solution:", checksum


################
# begin part 2 #
################

letters_in_common = ""

# I'll bet a trie or something would be good for this
# too bad I don't know anything so I did it the brute force way :(
# but hey Array#combination is pretty fun and smart
# and look at that (block argument destructuring)!
boxes.combination(2).each do |(box1, box2)|
  if box1.differ_by_one_letter? box2
    letters_in_common = box1.letters_in_common_with box2
    break
  end
end

puts "Day 2 Part 2 solution:", letters_in_common
