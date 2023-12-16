file = File.open('16/gold/input.txt')
input = file.read

@grid = {}
max_row_id = 0
max_column_id = 0

input.split("\n").each_with_index do |row, row_id|
  row.split("").each_with_index do |cell, column_id|
    @grid[[row_id, column_id]] = cell
    max_row_id = [max_row_id, row_id].max
    max_column_id = [max_column_id, column_id].max
  end
end

def step(row_id, column_id, direction, beam_id = 0)
  return if @grid[[row_id, column_id]].nil?
  return if @beam_tracker[[beam_id, row_id, column_id, direction]] && @beam_tracker[[beam_id, row_id, column_id, direction]] > 1

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

def reset_trackers
  @energised = {}
  @beam_tracker = {}
end

reset_trackers
result = 0
(0..max_column_id).each do |column_id|
  step(0, column_id, :down)
  result = [@energised.size, result].max
  reset_trackers

  step(max_row_id, column_id, :up)
  result = [@energised.size, result].max
  reset_trackers
end

(0..max_row_id).each do |row_id|
  step(row_id, 0, :right)
  result = [@energised.size, result].max
  reset_trackers

  step(row_id, max_column_id, :left)
  result = [@energised.size, result].max
  reset_trackers
end

puts result
