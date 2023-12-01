file = File.open("input.txt")
input = file.read.split("\n")

WORD_DICT = {
  one: "1",
  two: "2",
  three: "3",
  four: "4",
  five: "5",
  six: "6",
  seven: "7",
  eight: "8",
  nine: "9",
}

def get_number(word_or_number)
  WORD_DICT[word_or_number.to_sym] || word_or_number
end

digit_regex = /(\d|#{WORD_DICT.keys.join("|")})/
reversed_digit_regex = /(\d|#{WORD_DICT.keys.map(&:to_s).map(&:reverse).join("|")})/

result = 0

input.each do |line|
  first_number = get_number(line.scan(digit_regex).first.first)
  last_number = get_number(line.reverse.scan(reversed_digit_regex).first.last.reverse)
  result += (first_number + last_number).to_i
end

puts result
