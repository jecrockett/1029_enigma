class OffsetGenerator

  def offsets(key, date)
    key_offsets = generate_key_offsets(key)
    date_offsets = generate_date_offsets(date)
    generate_final_offsets(key_offsets, date_offsets)
  end

  def generate_key_offsets(key)
    first_digits = array_of_first_digits(key)
    second_digits = array_of_second_digits(key)
    key_offsets(first_digits, second_digits)
  end

  def generate_date_offsets(date)
    binding.pry
    date = date.to_i
    date_squared = date*date
    binding.pry
    last_four = date_squared.to_s[-4..-1]
    binding.pry
    last_four.chars.map do |char|
      char.to_i
    end
  end

  def generate_final_offsets(key_offsets, date_offsets)
    matched = key_offsets.zip(date_offsets)
    matched.map do |pair|
      pair[0] + pair[1]
    end
  end

  def array_of_first_digits(key)
    first_digits = key.to_s.chars
    first_digits.pop
    first_digits
  end

  def array_of_second_digits(key)
    second_digits = key.to_s.chars
    second_digits.shift
    second_digits
  end

  def key_offsets(first_digits, second_digits)
    combined = first_digits.zip(second_digits)
    combined.map do |pair|
      pair.join.to_i
    end
  end



end
