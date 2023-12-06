file = File.open("6/silver/input.txt")
input_rows = file.read.split("\n")

recorded_times = input_rows[0].scan(/(\d+)/).flatten.map(&:to_i)
recorded_distances = input_rows[1].scan(/(\d+)/).flatten.map(&:to_i)

result = 1
recorded_times.zip(recorded_distances).each do |recorded_time, recorded_distance|
  race_result = 0
  (0..recorded_time).each do |speed|
    time_left = recorded_time - speed
    distance = speed * time_left
    if distance > recorded_distance
      race_result += 1
    end
  end

  result *= race_result
end

puts result
