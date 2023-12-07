file = File.open("7/gold/input.txt")
input_rows = file.read.split("\n")

@cards_to_values = {"A" => "A", "K" => "B", "Q" => "C", "T" => "E", "9" => "F", "8" => "G", "7" => "H", "6" => "I", "5" => "J", "4" => "K", "3" => "L", "2" => "M", "J" => "N"}

def normalized_card(hand)
  hand.split("").map do |card|
    @cards_to_values[card]
  end.join
end

def card_rank(hand)
  hand = hand.split("")
  if hand.uniq.size == 1
    "A"
  elsif hand.tally.values.sort == [1, 4]
    "B"
  elsif hand.tally.values.sort == [2, 3]
    "C"
  elsif hand.tally.values.sort == [1, 1, 3]
    "D"
  elsif hand.tally.values.sort == [1, 2, 2]
    "E"
  elsif hand.tally.values.sort == [1, 1, 1, 2]
    "F"
  elsif hand.tally.values.sort == [1, 1, 1, 1, 1]
    "G"
  end
end

def replace_jokers(hand)
  replace_with = "A"
  hand.split("").tally.to_a.sort_by(&:last).reverse.each do |card, _count|
    if card != "J"
      replace_with = card
      break
    end
  end

  hand.gsub("J", replace_with)
end

normalized_hands = []
input_rows.each do |row|
  hand, bid = row.split(" ")
  bid = bid.to_i

  replaced_jokers = replace_jokers(hand)
  rank = card_rank(replaced_jokers)
  normalized_hand = rank + normalized_card(hand)

  normalized_hands << [normalized_hand, hand, bid]
end

result = 0
normalized_hands.sort_by(&:first).reverse.each_with_index do |(_normalized_hand, _hand, bid), i|
  result += bid * (i + 1)
end

puts result
