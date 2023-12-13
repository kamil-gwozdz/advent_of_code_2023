file = File.open('13/silver/input.txt')
input_matrices = file.read.split("\n\n")

matrices = []

result = 0
input_matrices.each do |input_matrix|
  matrix = []
  input_matrix.split("\n").each do |line|
    row = line.split('')
    matrix << row
  end

  matrices << matrix
end

def upper_row_candidates(matrix)
  (0..matrix.size-2).to_a
end

def reflects?(matrix, upper_row_candidate)
  upper_row = upper_row_candidate
  lower_row = upper_row_candidate + 1

  reflection = true
  while upper_row >= 0 && lower_row < matrix.size
    if matrix[upper_row] != matrix[lower_row]
      reflection = false
      break
    end

    upper_row -= 1
    lower_row += 1
  end

  reflection
end

matrices.each do |matrix|
  upper_row_candidates(matrix).each do |upper_row_candidate|
    result += (upper_row_candidate + 1) * 100 if reflects?(matrix, upper_row_candidate)
  end

  matrix = matrix.map(&:reverse).transpose.reverse
  upper_row_candidates(matrix).each do |upper_row_candidate|
    result += upper_row_candidate + 1 if reflects?(matrix, upper_row_candidate)
  end
end

puts result
                                                                   
