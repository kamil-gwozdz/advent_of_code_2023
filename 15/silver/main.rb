file = File.open('15/silver/input.txt')
input = file.read.strip


def hash(word)
  result = 0
  word.each_byte do |ascii_value|
    result += ascii_value
    result *= 17
    result %= 256
  end

  result
end

result = input.split(",").sum do |word|
  hash(word)
end
puts result
