#!/usr/bin/env ruby

# solutions to part 1 and 2 of:
# https://adventofcode.com/2018/day/3

################
# begin part 1 #
################

class Claim
  attr_reader :x, :y, :width, :height

  # ooooo boy wish I knew regexes better
  # actually I did fine nevermind I am perfect
  PARSE_REGEX = /#(?<id>\d+) @ (?<x>\d+),(?<y>\d+): (?<width>\d+)x(?<height>\d+)/

  def initialize x, y , width, height
    @x = x.to_i
    @y = y.to_i
    @width = width.to_i
    @height = height.to_i
  end

  def self.parse(claim_str)
    match = PARSE_REGEX.match(claim_str)
    self.new(
      match["x"],
      match["y"],
      match["width"],
      match["height"]
    )
  end

  # this is somewhat of a mess, eh?
  # also I now realize this approach is not useful for the actual problem at hand
  # so this is all WORTHLESS at least for Part 1 but I'm keeping it
  def overlapping_area_with other_claim
    x_edge = (x...(x + width)).to_a
    other_x_edge = (other_claim.x...(other_claim.x + other_claim.width)).to_a
    overlapping_x_squares = x_edge & other_x_edge

    y_edge = (y...(y + height)).to_a
    other_y_edge = (other_claim.y...(other_claim.y + other_claim.height)).to_a
    overlapping_y_squares = y_edge & other_y_edge

    overlapping_x_squares.length * overlapping_y_squares.length
  end
end

class Fabric
  def initialize
    @claim_counts = Hash.new { |hash, key| hash[key] = Hash.new(0) }
  end

  def mark_claim claim
    (claim.x...(claim.x + claim.width)).each do |x|
      (claim.y...(claim.y + claim.height)).each do |y|
        @claim_counts[x][y] += 1
      end
    end
  end

  def multiply_claimed_square_inches
    @claim_counts.map do |x, y_hash|
      y_hash.count { |y, claim_count| claim_count > 1 }
    end.inject(:+)
  end
end

# look at this methodical scientific testing preserved for ever
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
