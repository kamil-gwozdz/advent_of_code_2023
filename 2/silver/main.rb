file = File.open("input.txt")
input = file.read.split("\n")


max_red = 12
max_green = 13
max_blue = 14

result = 0

input.each do |line|
  game_number = line.scan(/Game (\d+):/).first.first.to_i
  invalid_game = false

  line.split(";").each do |game|
    blue = game.scan(/(\d+) blue/).map(&:first).first.to_i
    green = game.scan(/(\d+) green/).map(&:first).first.to_i
    red = game.scan(/(\d+) red/).map(&:first).first.to_i

    if blue > max_blue || green > max_green || red > max_red
      invalid_game = true
    end
  end

  next if invalid_game

  result += game_number.to_i
end

puts result
