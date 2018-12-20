#!/usr/bin/env ruby

# solutions to part 1 and 2 of:
# https://adventofcode.com/2018/day/4

################
# begin part 1 #
################

input_path = File.expand_path("input.txt", File.dirname(__FILE__))

polymer = File.read(input_path).chomp

# test_polymer = "dabAcCaCBAcCcaDA"
# stable_test_polymer = "dabCBAcaDA"

def reactive_pair? mer1, mer2
  mer1 != mer2 && mer1.upcase == mer2.upcase
end

def stable_pair? mer1, mer2
  !reactive_pair? mer1, mer2
end

def stable_polymer? mers
  mers.each_cons(2).all? { |(mer1, mer2)| stable_pair? mer1, mer2 }
end

def react! mers
  stable = false
  until stable
    stable = true
    mers.each_index do |idx|
      next if mers[idx].nil? || mers[idx + 1].nil?
      if reactive_pair? mers[idx], mers[idx + 1]
        stable = false
        mers[idx] = nil
        mers[idx + 1] = nil
      end
    end
    mers.compact!
  end
  mers
end

reacted_mers = react! polymer.chars

puts "this solution is slow but something is happening..."
puts "Day 5 Part 1 solution:", reacted_mers.length


################
# begin part 2 #
################

shortest_possible_polymer_length = reacted_mers.length

("a".."z").each do |unit|
  pruned_polymer = polymer.gsub /(#{unit}|#{unit.upcase})/, ""
  pruned_mers = pruned_polymer.chars
  reacted_pruned_mers = react! pruned_mers
  if reacted_pruned_mers.length < shortest_possible_polymer_length
    shortest_possible_polymer_length = reacted_pruned_mers.length
  end
end

puts "this solution is EXTREMELY slow but something is happening..."
puts "Day 5 Part 2 solution:",  shortest_possible_polymer_length
