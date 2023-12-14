file = File.open('14/silver/input.txt')
input = file.read

matrix = []
input.split("\n").each do |line|
  row = line.split('')
  matrix << row
end

matrix = matrix.transpose.map(&:reverse) # rotate 90 degrees clockwise

def fall_stones(row)
  while row.join.include?('O.') do
    row.size.times do |cell_id|
      if row[cell_id] == 'O' && row[cell_id+1] == '.'
        row[cell_id] = '.'
        row[cell_id + 1] = 'O'
      end
    end
  end

  row
end

matrix.each_with_index do |row, row_id|
  matrix[row_id] = fall_stones(row)
end

result = 0
matrix.each do |row|
  row.each_with_index do |cell, cell_id|
    result += cell_id + 1 if cell == 'O'
  end
end

puts result

