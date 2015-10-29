class KeyCrack

  def interpret_key(actual_ending, expected_ending, message, date_offsets)
    nr = NumberRotater.new
    rotations = nr.subtract(actual_ending, expected_ending)
    reduced = nr.reduce(rotations)
    final_offsets = arrange_order(message, reduced)
    key_offsets = nr.subtract(final_offsets, date_offsets)
    key = key(key_offsets)
  end

  def extract_ending(message)
    if message.chars.length >= 7
      message[-7..-1]
    else
      puts "Not enough characters to extract."
      return nil
    end
  end

  # def calculate_difference(actual, expected)
  #   combined = actual.zip(expected)
  #   combined.map do |pair|
  #     pair[0] - pair[1]
  #   end
  # end

  def arrange_order(message, differences)
    remainder = message.length % 4
    case remainder
    when 0
      differences[-4..-1]
    when 1
      differences[-5..-2]
    when 2
      differences[-6..-3]
    when 3
      differences [-7..-4]
    end
  end

  def key(key_offsets)
    first_two = key_offsets.shift
    key = first_two.to_s.chars
    key_offsets.each do |offset|
      key << offset.to_s[-1]
    end
    key = key.join.to_i
  end

end
