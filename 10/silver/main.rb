file = File.open("10/silver/input.txt")
lines = file.read.split("\n")

matrix = []
visited = {}
result = 0

lines.each do |line|
  matrix << line.split("")
end

start_row = nil
start_column = nil

matrix.each_with_index do |row, row_index|
  row.each_with_index do |cell, column_index|
    if cell == "S"
      start_row = row_index
      start_column = column_index
    end
  end
end

current_row = start_row
current_column = start_column

current_row -= 1 # i checked my input and first step is to the top
# current_column += 1 # demo input

loop do
  case matrix[current_row][current_column]
  when "-"
    if visited[[current_row, current_column + 1]]
      current_column -= 1
    else
      current_column += 1
    end
  when "|"
    if visited[[current_row + 1, current_column]]
      current_row -= 1
    else
      current_row += 1
    end
  when "L"
    if visited[[current_row - 1, current_column]]
      current_column += 1
    else
      current_row -= 1
    end
  when "J"
    if visited[[current_row - 1, current_column]]
      current_column -= 1
    else
      current_row -= 1
    end
  when "7"
    if visited[[current_row, current_column - 1]]
      current_row += 1
    else
      current_column -= 1
    end
  when "F"
    if visited[[current_row + 1, current_column]]
      current_column += 1
    else
      current_row += 1
    end
  end

  visited[[current_row, current_column]] = true
  
  result += 1

  break if current_row == start_row && current_column == start_column
end

puts (result+1)/2
