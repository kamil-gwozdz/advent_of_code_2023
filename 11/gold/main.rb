file = File.open("11/gold/input.txt")
lines = file.read.split("\n")

input_matrix = []
EMPTY_ROW_MULTIPLIER = 1000000

lines.each do |line|
  input_matrix << line.split("")
end

galaxies_locations = []
empty_rows = []
empty_columns = (0...input_matrix.first.size).to_a

input_matrix.each_with_index do |row, row_id|
  empty_rows << row_id if row.all? { |char| char == "." }

  row.each_with_index do |char, column_id|
    galaxies_locations << [row_id, column_id] if char == "#"

    empty_columns.delete(column_id) if char == "#"
  end
end

result = 0
galaxies_locations.combination(2).each do |galaxy1, galaxy2|
  galaxy1_row, galaxy1_column = galaxy1
  galaxy2_row, galaxy2_column = galaxy2

  galaxy_row1, galaxy_row2 = [galaxy1_row, galaxy2_row].sort
  galaxy_column1, galaxy_column2 = [galaxy1_column, galaxy2_column].sort
  
  multiplied_rows = empty_rows.select { |row| (row > galaxy_row1 && row < galaxy_row2) }
  multiplied_columns = empty_columns.select { |column| (column > galaxy_column1 && column < galaxy_column2) }

  distance = galaxy_row2 - galaxy_row1 + multiplied_rows.size * (EMPTY_ROW_MULTIPLIER-1) + galaxy_column2 - galaxy_column1 + multiplied_columns.size * (EMPTY_ROW_MULTIPLIER-1)

  result += distance
end

puts result

