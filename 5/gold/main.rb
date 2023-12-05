require 'bundler/inline'

gemfile do
  gem "activesupport"
  gem "multi_range"
end
require "active_support/all"

file = File.open("5/gold/input.txt")
input_rows = file.read.split("\n")

seed_ranges = []
ranges = input_rows[0].scan(/(\d+)/).flatten.map(&:to_i)
ranges.each_slice(2) do |beginning, length|
  seed_ranges << (beginning..beginning+length-1)
end

@elements = %w[seed soil fertilizer water light temperature humidity location]
from_element, to_element = nil, nil

@elements_map = {}

input_rows.each do |line|
  next if line.start_with?("seeds:") || line == ""

  if line.end_with?("map:")
    from_element, to_element = line.scan(/(\w+)-to-(\w+)/).flatten
    next
  end

  to_range_start, from_range_start, range_length = line.split(" ").map(&:to_i)

  @elements_map[[from_element, to_element]] ||= []
  @elements_map[[from_element, to_element]] << {
    from_range: (from_range_start..from_range_start+range_length-1),
    offset: to_range_start - from_range_start,
  }
end


def process_range(range, element_idx, tmp_result)
  if @elements[element_idx] == @elements.last
    return [range.begin, tmp_result].min
  end

  from_element = @elements[element_idx]
  to_element = @elements[element_idx+1]

  old_value_ranges = MultiRange.new([range])
  @elements_map[[from_element, to_element]].each do |mapping|
    next unless mapping[:from_range].overlaps?(range)

    old_value_ranges -= MultiRange.new([mapping[:from_range]])
    new_value_ranges = MultiRange.new([range]) & MultiRange.new([mapping[:from_range]])

    new_value_ranges.ranges.each do |new_value_range|
      new_range = (new_value_range.begin + mapping[:offset])..(new_value_range.end + mapping[:offset])
      tmp_result = [process_range(new_range, element_idx+1, tmp_result), tmp_result].min
    end
  end

  old_value_ranges.ranges.each do |old_value_range|
    tmp_result = [process_range(old_value_range, element_idx+1, tmp_result), tmp_result].min
  end

  tmp_result
end

result = 999999999999999999999999
seed_ranges.each do |range|
  result = [process_range(range, 0, result), result].min
end

puts result
