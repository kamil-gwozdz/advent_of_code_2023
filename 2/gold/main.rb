file = File.open("input.txt")
input = file.read.split("\n")

result = 0

input.each do |line|
  game_number = line.scan(/Game (\d+):/).first.first.to_i

  blues = []
  greens = []
  reds = []

  line.split(";").each do |game|
    blues << game.scan(/(\d+) blue/).map(&:first).first.to_i
    greens << game.scan(/(\d+) green/).map(&:first).first.to_i
    reds << game.scan(/(\d+) red/).map(&:first).first.to_i
  end

  result += blues.max * greens.max * reds.max
end

puts result
