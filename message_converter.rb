class MessageConverter

  def full_index
    (" ".."z").to_a
  end

  def convert_to_numbers(string)
    chars = string.chars
    chars.map do |char|
      full_index.index(char)
    end
  end

  def convert_to_letters(array)
    letters = array.map do |number|
      full_index.values_at(number)
    end
    letters.join
  end

end
