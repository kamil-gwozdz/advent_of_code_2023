file = File.open('16/silver/input.txt')
input = file.read

@energised = {}
@grid = {}
@beam_tracker = {}

input.split("\n").each_with_index do |row, row_id|
  row.split("").each_with_index do |cell, column_id|
    @grid[[row_id, column_id]] = cell
  end
end

def step(row_id, column_id, direction, beam_id = 0)
  return if @grid[[row_id, column_id]].nil?
  return if @beam_tracker[[beam_id, row_id, column_id, direction]]&.> 1

  @energised[[row_id, column_id]] = true
  @beam_tracker[[beam_id, row_id, column_id, direction]] ||= 0
  @beam_tracker[[beam_id, row_id, column_id, direction]] += 1

  # next cell assuming no mirrors or splitters
  next_row_id = row_id
  next_column_id = column_id
  case direction
  when :up
    next_row_id -= 1
  when :down
    next_row_id += 1
  when :left
    next_column_id -= 1
  when :right
    next_column_id += 1
  end

  case @grid[[row_id, column_id]]
  when "|"
    if direction == :up || direction == :down
      step(next_row_id, next_column_id, direction)
    else
      step(row_id - 1, column_id, :up, beam_id)
      step(row_id + 1, column_id, :down, beam_id + 1)
    end
  when "-"
    if direction == :left || direction == :right
      step(next_row_id, next_column_id, direction)
    else
      step(row_id, column_id - 1, :left, beam_id)
      step(row_id, column_id + 1, :right, beam_id + 1)
    end
  when "."
    step(next_row_id, next_column_id, direction)
  when "/"
    case direction
    when :up
      step(row_id, column_id + 1, :right)
    when :down
      step(row_id, column_id - 1, :left)
    when :left
      step(row_id + 1, column_id, :down)
    when :right
      step(row_id - 1, column_id, :up)
    end
  when "\\"
    case direction
    when :up
      step(row_id, column_id - 1, :left)
    when :down
      step(row_id, column_id + 1, :right)
    when :left
      step(row_id - 1, column_id, :up)
    when :right
      step(row_id + 1, column_id, :down)
    end
  end

end

step(0, 0, :right)

puts @energised.size
