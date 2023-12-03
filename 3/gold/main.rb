file = File.open("3/gold/input.txt")
input = file.read

result = 0

def get_number(matrix, number_location)
  number = ""
  column_idx = number_location[:column_idx]
  line_idx = number_location[:line_idx]

  while matrix[line_idx][column_idx]&.match(/\d/)
    number += matrix[line_idx][column_idx]
    column_idx += 1
  end

  number.to_i
end

matrix = Hash.new({})
number_locations = [] # [{ column_idx: 0, line_idx: 0, length: 1 }, ...]

input.split("\n").each_with_index do |line, line_idx|
  matrix[line_idx] = {}
  processing_number = false

  line.split("").each_with_index do |char, column_idx|
    if processing_number && !char.match(/\d/)
      processing_number = false
    end

    if !processing_number && char.match(/\d/)
      processing_number = true
      number_locations << {
        column_idx: column_idx,
        line_idx: line_idx,
        length: 0,
      }
    end

    number_locations.last[:length] += 1 if processing_number

    matrix[line_idx][column_idx] = char
  end
end

gears_to_numbers = {}

number_locations.each do |number_location|
  adjacent_idxs = []
  adjacent_idxs << [number_location[:line_idx], number_location[:column_idx] - 1]
  adjacent_idxs << [number_location[:line_idx], number_location[:length] + number_location[:column_idx]]

  (number_location[:column_idx]-1).upto(number_location[:column_idx] + number_location[:length]).each do |column_idx|
    adjacent_idxs << [number_location[:line_idx] - 1, column_idx]
    adjacent_idxs << [number_location[:line_idx] + 1, column_idx]
  end

  adjacent_idxs.each do |line_idx, column_idx|
    if matrix[line_idx][column_idx] == "*"
      gears_to_numbers[[line_idx, column_idx]] ||= []
      gears_to_numbers[[line_idx, column_idx]] << number_location
    end
  end
end

gears_to_numbers.each do |_gear, numbers|
  if numbers.length == 2
    result += get_number(matrix, numbers[0]) * get_number(matrix, numbers[1])
  end
end

puts result
