require "memoist"
extend Memoist

file = File.open('12/gold/input.txt')
lines = file.read.split("\n")

def number(map, groups)
  map.gsub!(/^\.+/, "")

  return 1 if map == '' && groups.empty?
  return 0 if map == '' && !groups.empty?
  return 1 if groups.empty? && !map.include?('#')
  return 0 if groups.empty? && map.include?('#')

  if map[0] == '#'
    if groups.first > map.size || map[0, groups.first].include?('.') || map[groups.first] == '#'
      0
    elsif map.size == groups.first
      [groups.size, 1].min
    else
      number(map[groups.first+1..], groups[1..])
    end
  else
    number('#' + map[1..], groups) + number(map[1..], groups)
  end
end
memoize :number

result = 0
lines.each do |line|
  map, groups = line.split(' ')
  groups = groups.split(',').map(&:to_i)

  map = map + '?' + map + '?' + map + '?' + map + '?' + map
  groups = groups + groups + groups + groups + groups

  result += number(map, groups)
end

puts result
