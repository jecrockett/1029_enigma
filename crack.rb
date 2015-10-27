require './number_rotater'

class KeyCrack

  def final_offsets(message)
    ending = @c.extract_ending(message)
    ending = @mc.convert_to_numbers(ending)
    expected_ending = [14, 14, 69, 78, 68, 14, 14]
    differences = @nr.subtract(ending, expected_ending)
    reduced = @nr.reduce(differences)
    final_offsets = @c.arrange_order(message, reduced)
  end

  def extract_ending(message)
    message[-7..-1]
  end

  def unique(numbers)
    numbers.uniq
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
      differences[-7..-4]
    when 2
      differences[-6..-3]
    when 3
      differences [-5..-2]
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
