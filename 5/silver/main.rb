file = File.open("5/silver/input.txt")
input_rows = file.read.split("\n")

seeds = input_rows[0].scan(/(\d+)/).flatten.map(&:to_i)
elements = %w[seed soil fertilizer water light temperature humidity location]
from_element, to_element = nil, nil

elements_map = {}

input_rows.each do |line|
  next if line.start_with?("seeds:") || line == ""

  if line.end_with?("map:")
    from_element, to_element = line.scan(/(\w+)-to-(\w+)/).flatten
    next
  end

  to_range_start, from_range_start, range_length = line.split(" ").map(&:to_i)

  elements_map[[from_element, to_element]] ||= []
  elements_map[[from_element, to_element]] << {
    from_range: (from_range_start..from_range_start+range_length-1),
    to_range_start: to_range_start,
    range_length: range_length,
  }
end

result = 999999999999999999999999
seeds.each do |seed|
  elements.each_with_index do |from_element, i|
    to_element = elements[i+1]
    break if to_element.nil?

    elements_map[[from_element, to_element]].each do |mapping|
      if mapping[:from_range].include?(seed)
        seed = mapping[:to_range_start] + (seed - mapping[:from_range].begin)
        break
      end
    end
  end

  result = [seed, result].min
end

puts result
