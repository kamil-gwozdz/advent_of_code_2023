file = File.open('14/gold/input.txt')
input = file.read

matrix = []
input.split("\n").each do |line|
  row = line.split('')
  matrix << row
end

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

def support_stones(matrix)
  result = 0
  matrix.transpose.map(&:reverse).each do |row|
    row.each_with_index do |cell, cell_id|
      result += cell_id + 1 if cell == 'O'
    end
  end

  result
end

def matrix_caching_key(matrix)
  matrix.flatten.join
end

cache = {}
sequence = []
1000000000.times do |cycle|
  4.times do
    matrix = matrix.transpose.map(&:reverse) # rotate 90 degrees clockwise
    matrix.each_with_index do |row, row_id|
      matrix[row_id] = fall_stones(row)
    end
  end

  support_stones = support_stones(matrix)
  if cache[matrix_caching_key(matrix)]
    # make a breakpoint here when this line prints something
    # then check the `cache.values.inspect` and figure out the correct index
    puts "cycle: #{cycle}"
  else
    cache[matrix_caching_key(matrix)] = cycle
    sequence << support_stones
  end
end

puts cache.values.inspect



