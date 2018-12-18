#!/usr/bin/env ruby

# solutions to part 1 and 2 of:
# https://adventofcode.com/2018/day/4

################
# begin part 1 #
################

require "date"

PARSE_REGEX = /^\[(?<datetime_str>.+)\]( Guard #(?<guard_id>\d+))? (?<verb>\w+) \w+$/

def parse str
  str = str.split("\n")
  events = str.map { |s| PARSE_REGEX.match s }
end

input_path = File.expand_path("input.txt", File.dirname(__FILE__))
input_str = File.read input_path

matches = parse input_str
# put events in chronological order
matches.sort_by! { |match| match["datetime_str"] }
events = matches.map { |match|
  {
    datetime: DateTime.parse(match["datetime_str"]),
    guard_id: match["guard_id"].to_i,
    verb: match["verb"]
  }
}

guards = {}
guard_on_duty = nil

events.each_with_index do |event, index|
  case event[:verb]
  when "begins"
    guards[event[:guard_id]] ||= Hash.new 0
    guard_on_duty = guards[event[:guard_id]]
  when "falls"
    sleep_start = event[:datetime].min
    sleep_finish = events[index + 1][:datetime].min
    # guard is awake on the minute they wake up, so we exclude the ending minute
    (sleep_start...sleep_finish).each do |minute|
      guard_on_duty[minute] += 1
    end
  when "wakes" then next
  end
end


sleepiest_guard_id, sleepiest_guard_minutes = guards.max_by do |guard_id, sleep_minutes_hash|
  sleep_minutes_hash.reduce(0) { |sum, (minute, count)| sum + count }
end

sleepiest_minute = sleepiest_guard_minutes.max_by { |minute, count| count }[0]

puts "Day 4 Part 1 solution:", sleepiest_guard_id * sleepiest_minute
