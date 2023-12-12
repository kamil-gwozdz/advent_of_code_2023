file = File.open('12/silver/input.txt')
lines = file.read.split("\n")


def valid_map?(map, groups)
  i = -1
  scanned = map.scan(/#+/)
  groups.size == scanned.size && scanned.all? do |group|
    i += 1
    group.size == groups[i]
  end
end

result = 0

lines.each do |line|
  map, groups = line.split(' ')
  groups = groups.split(',').map(&:to_i)

  unknown_locations = []
  known_locations_count = map.split("").select { |char, index| char == '#' }.size

  map.split("").each_with_index { |char, index| unknown_locations << index if char == '?' }

  missing_locations = groups.sum - known_locations_count

  unknown_locations.combination(missing_locations).each do |combination|
    tmp_map = map.dup
    combination.each { |index| tmp_map[index] = '#' }
    tmp_map.gsub!('?', '.')

    result += 1 if valid_map?(tmp_map, groups)
  end
end

puts result
                                                                   
