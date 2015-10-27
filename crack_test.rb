require 'minitest/autorun'
require './number_rotater'
require './offset_generator'
require './message_converter'
require './crack'

class KeyCrackTest < Minitest::Test

  def test_final_seven_digit_extraction
    c = KeyCrack.new
    message = "Hey how are you? ..end.."
    ending = c.extract_ending(message)
    assert_equal "..end..", ending
  end

  def test_extraction_with_less_than_seven_digits
    c = KeyCrack.new
    message = "hi"
    ending = c.extract_ending(message)
    assert_equal nil, ending
  end

  def test_difference_between_expected_and_actual
    nr = NumberRotater.new
    # using key = 63673 date = 271015
    expected = [14, 14, 69, 78, 68, 14, 14]
    actual = [77, 52, 47, 65, 40, 52, 83]
    # kos = 63 36 67 73
    # dos = 0  2  2  5
    difference = nr.subtract(actual, expected)
    assert_equal [63, 38, -22, -13, -28, 38, 69], difference
  end

  def test_reduced_differences
    nr = NumberRotater.new
    differences = [63, 38, -22, -13, -28, 38, 69]
    reduced = nr.reduce(differences)
    assert_equal [63, 38, 69, 78, 63, 38, 69], reduced
  end

  def test_arrange_order
    c = KeyCrack.new
    message = "hello, how are you? ..end.."
    reduced_differences = [63, 38, 69, 78, 63, 38, 69]
    offsets_in_order = c.arrange_order(message, reduced_differences)
    assert_equal [63, 38, 69, 78], offsets_in_order
  end

  def test_subtract_date_offsets
    nr = NumberRotater.new
    final_offsets = [63, 38, 69, 78]
    date_offsets = [0, 2, 2, 5]
    key_offsets = nr.subtract(final_offsets, date_offsets)
    assert_equal [63, 36, 67, 73], key_offsets
  end

  def test_key
    c = KeyCrack.new
    key_offsets = [63, 36, 67, 73]
    key = c.key(key_offsets)
    assert_equal 63673, key
  end
end
