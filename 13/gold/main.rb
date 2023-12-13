file = File.open('13/gold/input.txt')
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

def reflects_with_smudge?(matrix, upper_row_candidate)
  smudges_count = 0
  upper_row = upper_row_candidate
  lower_row = upper_row_candidate + 1

  while upper_row >= 0 && lower_row < matrix.size
    smudges_count += matrix[upper_row].zip(matrix[lower_row]).sum do |upper_cell, lower_cell|
      upper_cell == lower_cell ? 0 : 1
    end

    break if smudges_count > 1

    upper_row -= 1
    lower_row += 1
  end

  smudges_count == 1
end

matrices.each do |matrix|
  upper_row_candidates(matrix).each do |upper_row_candidate|
    result += (upper_row_candidate + 1) * 100 if reflects_with_smudge?(matrix, upper_row_candidate)
  end

  matrix = matrix.map(&:reverse).transpose.reverse
  upper_row_candidates(matrix).each do |upper_row_candidate|
    result += upper_row_candidate + 1 if reflects_with_smudge?(matrix, upper_row_candidate)
  end
end

puts result
