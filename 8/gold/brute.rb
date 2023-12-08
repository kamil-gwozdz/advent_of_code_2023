file = File.open("8/gold/input.txt")
input_rows = file.read.split("\n")

instructions = input_rows[0].split("")

map = {}

input_rows.each do |row|
  nodes = row.scan(/(\w+) = \((\w+), (\w+)\)/).first
  next unless nodes && nodes.length == 3

  from_node, left_node, right_node = nodes
  map[from_node] = [left_node, right_node]
end

current_nodes = map.keys.select{|node| node.split("").last == "A"}
result = 0

until current_nodes.all?{|node| node.split("").last == "Z"}
  instruction = instructions[result % instructions.size]

  current_nodes = current_nodes.map do |node|
    left_node, right_node = map[node]
    instruction == "L" ? left_node : right_node
  end

  result += 1
end

puts result

