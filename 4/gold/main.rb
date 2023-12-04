file = File.open("4/gold/input.txt")
input = file.read

result = 0

cards = [] # [{number: 1, matched_numbers_count: 3}, ...]
card_number_to_card = {} # {1 => {number: 1, matched_numbers_count: 3}, ...}

input.split("\n").each do |line|
  card_numbers = line.scan(/: ([\d ]+) \|/).first.first.strip.split(/\s+/)
  winning_numbers = line.scan(/\|([\d ]+)/).first.first.strip.split(/\s+/)
  matched_numbers_count = (card_numbers & winning_numbers).size
  card_number = line.scan(/Card\s+(\d+):/).first.first.to_i

  card = {
    number: card_number,
    matched_numbers_count: matched_numbers_count,
  }

  cards << card
  card_number_to_card[card_number] = card
end

cards.each do |card|
  card[:matched_numbers_count].times do |i|
    cards << card_number_to_card[card[:number]+i+1]
  end
end

puts cards.size
