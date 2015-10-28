class NumberRotater

  def encryption_rotation(numbers, offsets)
    binding.pry
    offsets = match_length(numbers, offsets)
    numbers = add(numbers, offsets)
    reduce(numbers)
  end

  def decryption_rotation(numbers, offsets)
    binding.pry
    offsets = match_length(numbers, offsets)
    numbers = subtract(numbers, offsets)
    reduce(numbers)
  end

  def match_length(numbers, offsets, new_offsets=[])
    if new_offsets.length > numbers.length
      delete_one_and_try_again(numbers, offsets, new_offsets)
    elsif new_offsets.length < numbers.length
      concatenate_and_try_again(numbers, offsets, new_offsets)
    else
      return new_offsets
    end
  end

  def add(numbers, offsets)
    combined = numbers.zip(offsets)
    combined.map do |pair|
      pair[0] + pair[1]
    end
  end

  def subtract(numbers, offsets)
    combined = numbers.zip(offsets)
    combined.map do |pair|
      pair[0] - pair[1]
    end
  end

  def reduce(numbers)
    numbers.map do |number|
      number % 91
    end
  end

  def delete_one_and_try_again(numbers, offsets, new_offsets)
    new_offsets.pop
    match_length(numbers, offsets, new_offsets)
  end

  def concatenate_and_try_again(numbers, offsets, new_offsets)
    new_offsets = new_offsets + offsets
    match_length(numbers, offsets, new_offsets)
  end

end
