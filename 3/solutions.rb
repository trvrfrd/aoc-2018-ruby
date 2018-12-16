#!/usr/bin/env ruby

# solutions to part 1 and 2 of:
# https://adventofcode.com/2018/day/3

################
# begin part 1 #
################

class Claim
  attr_reader :id, :x, :y, :width, :height

  # ooooo boy wish I knew regexes better
  # actually I did fine nevermind I am perfect
  PARSE_REGEX = /#(?<id>\d+) @ (?<x>\d+),(?<y>\d+): (?<width>\d+)x(?<height>\d+)/

  def self.parse(claim_str)
    match = PARSE_REGEX.match(claim_str)
    self.new(
      id: match["id"],
      x: match["x"],
      y: match["y"],
      width: match["width"],
      height: match["height"]
    )
  end

  def initialize id:, x:, y:, width:, height:
    @id = id
    @x = x.to_i
    @y = y.to_i
    @width = width.to_i
    @height = height.to_i
  end

  def x_range
    @x_range ||= (x...(x + width))
  end

  def y_range
    @y_range ||= (y...(y + height))
  end

  def x_overlap_with other_claim
    x_range.to_a & other_claim.x_range.to_a
  end

  def y_overlap_with other_claim
    y_range.to_a & other_claim.y_range.to_a
  end

  def overlaps_with? other_claim
    x_overlap_with(other_claim).length > 0 && y_overlap_with(other_claim).length > 0
  end

  # this is somewhat of a mess, eh?
  # also I now realize this approach is not useful for the actual problem at hand
  # so this is all WORTHLESS at least for Part 1 but I'm keeping it
  # and then I refactored it so it's less of a mess, wow
  def overlapping_area_with other_claim
    x_overlap_with(other_claim).length * y_overlap_with(other_claim).length
  end
end

class Fabric
  def initialize
    @claim_counts = Hash.new { |hash, key| hash[key] = Hash.new(0) }
  end

  def mark_claim claim
    claim.x_range.each do |x|
      claim.y_range.each do |y|
        @claim_counts[x][y] += 1
      end
    end
  end

  def multiply_claimed_square_inches
    @claim_counts.map { |x, y_hash|
      y_hash.count { |y, claim_count| claim_count > 1 }
    }.inject(:+)
  end
end

# look at this methodical scientific testing apparatus preserved for ever
#
# test_input = <<~EOS
# #1 @ 1,3: 4x4
# #2 @ 3,1: 4x4
# #3 @ 5,5: 2x2
# EOS
#
# test_claims = test_input.split("\n").map { |claim_str| Claim.parse(claim_str) }

input_path = File.expand_path("input.txt", File.dirname(__FILE__))
input = File.read(input_path)

claims = input.split("\n").map { |claim_str| Claim.parse(claim_str) }
fabric = Fabric.new

claims.each { |claim| fabric.mark_claim claim }

sqaure_inches_of_fabric_within_two_or_more_claims = fabric.multiply_claimed_square_inches

puts "Day 3 Part 1 solution:", sqaure_inches_of_fabric_within_two_or_more_claims


################
# begin part 2 #
################

# it's brute force and slow as hell but it's cute
non_overlapping_claim = claims.find do |claim|
  claims.none? do |other_claim|
    next if claim == other_claim
    claim.overlaps_with? other_claim
  end
end

if non_overlapping_claim.nil?
  puts "i fucked up"
else
  puts "Day 3 Part 2 solution:", non_overlapping_claim.id
end
