file = File.open("11/silver/input.txt")
lines = file.read.split("\n")

input_matrix = []

lines.each do |line|
  input_matrix << line.split("")
  input_matrix << input_matrix.last if input_matrix.last.all? { |char| char == "." }
end

input_matrix = input_matrix.transpose
tmp_matrix = []

input_matrix.each do |row|
  if row.all? { |char| char == "." }
    tmp_matrix << row
    tmp_matrix << row
  else
    tmp_matrix << row
  end
end

input_matrix = tmp_matrix.transpose.transpose.transpose # .transpose.transpose.transpose is not needed but im doing it to see the matrix in the right way
# puts input_matrix.map{ |row| row.join("") }.join("\n")

matrix = {}
input_matrix.each_with_index do |row, row_id|
  row.each_with_index do |char, column_id|
    matrix[[row_id, column_id]] = char
  end
end

result = 0
galaxies_locations = matrix.select { |_, char| char == "#" }.keys
galaxies_locations.combination(2).each do |galaxy1, galaxy2|
  galaxy1_x, galaxy1_y = galaxy1
  galaxy2_x, galaxy2_y = galaxy2

  distance = (galaxy1_x - galaxy2_x).abs + (galaxy1_y - galaxy2_y).abs

  result += distance
end

puts result

