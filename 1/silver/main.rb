file = File.open("input.txt")
input = file.read.split("\n")

result = 0
input.each do |line|
  number = line.scan(/\d/).first + line.scan(/\d/).last
  result += number.to_i
end

puts result
