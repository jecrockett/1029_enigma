require './number_rotater'

class KeyCrack

  def extract_ending(input)
    if input.chars.length >= 7
      input[-7..-1]
    else
      puts "Not enough characters to extract."
      return nil
    end
  end

  def calculate_difference(actual, expected)
    combined = actual.zip(expected)
    combined.map do |pair|
      pair[0] - pair[1]
    end
  end

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
