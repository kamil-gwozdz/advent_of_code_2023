file = File.open('15/gold/input.txt')
input = file.read.strip

def hash(word)
  result = 0
  word.each_byte do |ascii_value|
    result += ascii_value
    result *= 17
    result %= 256
  end

  result
end

box = {}

input.split(",").each do |instruction|
  lens_label, focal_length = instruction.split(/[-=]/)
  box_number = hash(lens_label)
  focal_length = focal_length.to_i

  box[box_number] ||= []
  lens_index = box[box_number].index { |lens| lens&.first == lens_label }

  if instruction.include?("=")
    if lens_index
      box[box_number][lens_index] = [lens_label, focal_length]
    else
      box[box_number] << [lens_label, focal_length]
    end
  else
    box[box_number][lens_index] = nil if lens_index
  end
end

result = 0
box.each do |box_number, lenses|
  lenses.compact.each_with_index do |lens, lens_index|
    result += (box_number+1)*(lens_index+1)*lens.last
  end
end

puts result
