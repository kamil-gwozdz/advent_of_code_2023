file = File.open("9/silver/input.txt")
lines = file.read.split("\n")

result = 0
lines.each do |line|
  readings = line.scan(/-*\d+/).map(&:to_i)
  sequences = []
  sequences << readings

  until sequences.last.all?(&:zero?) do
    new_sequence = []
    sequences.last.each_with_index do |number, index|
      break if sequences.last[index+1].nil?
      new_sequence << sequences.last[index+1] - number
    end
    sequences << new_sequence
  end

  sequences.reverse.each_with_index do |sequence, index|
    next if index == 0

    interpolated_number = sequence.last + sequences.reverse[index-1].last
    sequence << interpolated_number
  end

  result += sequences.first.last
end

# 19778457 too low
# 1969958987
puts result
