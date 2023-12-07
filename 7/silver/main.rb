file = File.open("7/silver/input.txt")
input_rows = file.read.split("\n")

cards_to_values = {"A" => "A", "K" => "B", "Q" => "C", "J" => "D", "T" => "E", "9" => "F", "8" => "G", "7" => "H", "6" => "I", "5" => "J", "4" => "K", "3" => "L", "2" => "M"}

normalized_hands = []
input_rows.each do |row|
  hand, bid = row.split(" ")
  bid = bid.to_i
  hand = hand.split("")

  normalized_hand = ""

  if hand.uniq.size == 1
    normalized_hand += "A"
  elsif hand.tally.values.sort == [1, 4]
    normalized_hand += "B"
  elsif hand.tally.values.sort == [2, 3]
    normalized_hand += "C"
  elsif hand.tally.values.sort == [1, 1, 3]
    normalized_hand += "D"
  elsif hand.tally.values.sort == [1, 2, 2]
    normalized_hand += "E"
  elsif hand.tally.values.sort == [1, 1, 1, 2]
    normalized_hand += "F"
  elsif hand.tally.values.sort == [1, 1, 1, 1, 1]
    normalized_hand += "G"
  end

  normalized_hand += hand.map do |card|
    cards_to_values[card]
  end.join

  normalized_hands << [normalized_hand, hand.join, bid]
end

result = 0
normalized_hands.sort_by(&:first).reverse.each_with_index do |(_normalized_hand, _hand, bid), i|
  result += bid * (i + 1)
end

puts result
