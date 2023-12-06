file = File.open("6/gold/input.txt")
input_rows = file.read.split("\n")

recorded_time = input_rows[0].scan(/(\d+)/).flatten.join("").to_i
recorded_distance = input_rows[1].scan(/(\d+)/).flatten.join("").to_i

result = 0
(0..recorded_time).each do |speed|
  time_left = recorded_time - speed
  distance = speed * time_left
  result += 1 if distance > recorded_distance
end

puts result
