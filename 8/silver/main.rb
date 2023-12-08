file = File.open("8/silver/input.txt")
input_rows = file.read.split("\n")

instructions = input_rows[0].split("")

map = {}

input_rows.each do |row|
  nodes = row.scan(/(\w+) = \((\w+), (\w+)\)/).first
  next unless nodes && nodes.length == 3

  from_node, left_node, right_node = nodes
  map[from_node] = [left_node, right_node]
end

result = 0
current_node = "AAA"
while current_node != "ZZZ"
  instruction = instructions[result % instructions.size]
  left_node, right_node = map[current_node]
  current_node = instruction == "L" ? left_node : right_node
  result += 1
end

puts result

