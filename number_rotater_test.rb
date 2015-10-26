require 'minitest/autorun'
require 'pry'
require './number_rotater'

class NumberRotaterTest < Minitest::Test

  def test_match_length
    nr = NumberRotater.new
    numbers = [66, 79, 83, 84, 79, 78]
    offsets = [12, 25, 36, 50]
    new_offsets = nr.match_length(numbers, offsets)
    assert_equal numbers.length, new_offsets.length
    assert_equal [12, 25, 36, 50, 12, 25], new_offsets
  end


  def test_encrypt
    nr = NumberRotater.new
    numbers = [66, 79, 83, 84, 79, 78]
    offsets = [12, 25, 36, 50, 12, 25]
    assert_equal [78, 104, 119, 134, 91, 103], nr.encrypt(numbers, offsets)
  end

  def test_decrypt
    nr = NumberRotater.new
    numbers = [78, 104, 119, 134, 91, 103]
    offsets = [12, 25, 36, 50, 12, 25]
    assert_equal [66, 79, 83, 84, 79, 78], nr.decrypt(numbers, offsets)
  end

  def test_reduce
    nr = NumberRotater.new
    numbers = [78, 104, 119, 134, 91, 103]
    reduced_numbers = nr.reduce(numbers)
    assert_equal [78, 13, 28, 43, 0, 12], reduced_numbers

    numbers = [66, 79, 83, 84, 79, 78]
    reduced_numbers = nr.reduce(numbers)
    assert_equal [66, 79, 83, 84, 79, 78], reduced_numbers
  end

  def test_encryption_rotation
    nr = NumberRotater.new
    numbers = [66, 79, 83, 84, 79, 78]
    offsets = [12, 25, 36, 50]
    rotated_numbers = nr.encryption_rotation(numbers, offsets)
    assert_equal [78, 13, 28, 43, 0, 12], rotated_numbers
  end

  def test_decryption_rotation
    nr = NumberRotater.new
    numbers = [78, 13, 28, 43, 0, 12]
    offsets = [12, 25, 36, 50]
    rotated_numbers = nr.decryption_rotation(numbers, offsets)
    assert_equal [66, 79, 83, 84, 79, 78], rotated_numbers
  end

end
