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
end_nodes_to_distance = map.keys.select{|node| node.split("").last == "Z"}.map{|node| [node, nil]}.to_h
result = 0

until end_nodes_to_distance.values.all?
  instruction = instructions[result % instructions.size]

  current_nodes = current_nodes.map do |node|
    left_node, right_node = map[node]
    new_node = instruction == "L" ? left_node : right_node

    if new_node.split("").last == "Z"
      end_nodes_to_distance[new_node] = result+1
    end

    new_node
  end

  result += 1
end

puts end_nodes_to_distance.values.inject(&:lcm)
