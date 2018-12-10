#!/usr/bin/env ruby

# solutions to part 1 and 2 of:
# https://adventofcode.com/2018/day/2

################
# begin part 1 #
################

# what if I did things... the OOP way?!
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

  def differ_by_one_letter? other_box_id
    differing_letter_counts = 0
    (0...id.length).each do |idx|
      differing_letter_counts += 1 if id[idx] != other_box_id.id[idx]
      return false if differing_letter_counts > 1
    end

    true
  end

  def letters_in_common_with other_box_id
    common_letters = id
    id.each_char.with_index do |_, idx|
      if id[idx] != other_box_id.id[idx]
        common_letters[idx] = ""
        break
      end
    end
    common_letters
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

letters_in_common = ""

# I'll bet a trie or something would be good for this
# too bad I don't know anything so I did it the brute force way :(
# but hey Array#permutaion is pretty fun and smart
# and look at that (block argument destructuring)!
box_ids.permutation(2).each do |(id1, id2)|
  if id1.differ_by_one_letter? id2
    letters_in_common = id1.letters_in_common_with id2
    break
  end
end

puts "Day 2 Part 2 solution:", letters_in_common
