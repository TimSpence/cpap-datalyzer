#!/usr/bin/env ruby

require "rubygems"
require "edfize"

$VERBOSE=false

raw_timezone_offset = "-05:00"

if ARGV.nil? || ARGV.empty?
  $stderr.puts "Error: No input file specified"
  exit 1
else
  input_file = ARGV.shift
end

edf = Edfize::Edf.new(input_file)

raw_start_date = edf.start_date_of_recording
raw_start_time = edf.start_time_of_recording
$stderr.puts "Original start date of recording was #{raw_start_date}" if $VERBOSE
$stderr.puts "Original start time of recording was #{raw_start_time}" if $VERBOSE

raw_start_date_arr = raw_start_date.split(".")
year, month, day = ("20" + raw_start_date_arr[2]), raw_start_date_arr[1], raw_start_date_arr[0]
raw_start_time_arr = raw_start_time.split(".")
hour, minute, second = raw_start_time_arr[0], raw_start_time_arr[1], raw_start_time_arr[2]
t = Time.new(year, month, day, hour, minute, second, raw_timezone_offset)
$stderr.puts "t is #{t}" if $VERBOSE

localtime = t.getlocal
$stderr.puts "local time is #{localtime}" if $VERBOSE

transformed_start_date = localtime.strftime "%d.%m.%y"
$stderr.puts "fixed_start_date = #{transformed_start_date}" if $VERBOSE

transformed_start_time = localtime.strftime "%H.%M.%S"
$stderr.puts "fixed_start_time = #{transformed_start_time}" if $VERBOSE

transformed_timezone_offset = localtime.strftime "%:z"
$stderr.puts "fixed_timezone_offset = #{transformed_timezone_offset}" if $VERBOSE

Edfize.edfs do |edf|
  edf.update(start_date_of_recording: transformed_start_date)
  edf.update(start_time_of_recording: transformed_start_time)
end

puts "input_file,raw_start_date,raw_start_time,raw_timezone_offset,transformed_start_date,transformed_start_time,transformed_timezone_offset"
puts "#{input_file},#{raw_start_date},#{raw_start_time},#{raw_timezone_offset},#{transformed_start_date},#{transformed_start_time},#{transformed_timezone_offset}"
