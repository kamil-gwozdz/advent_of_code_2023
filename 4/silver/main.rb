file = File.open("4/silver/input.txt")
input = file.read

result = 0

input.split("\n").each do |line|
  card_numbers = line.scan(/: ([\d ]+) \|/).first.first.strip.split(/\s+/)
  winning_numbers = line.scan(/\|([\d ]+)/).first.first.strip.split(/\s+/)

  result += 2**((card_numbers & winning_numbers).size-1) if (card_numbers & winning_numbers).size > 0
end

puts result
