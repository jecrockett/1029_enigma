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

  def test_date_offsets
    og = OffsetGenerator.new
    date = 311015
    date_offsets = og.generate_date_offsets(date)
    assert_equal 4, date_offsets.length
    assert_equal [0, 2, 2, 5], date_offsets
  end

  # def test_expected_final_numbers
  #   mc = MessageConverter.new
  #   message = "..end.."
  #   expected_numbers = mc.convert_to_numbers(message)
  #   assert_equal [14, 14, 69, 78, 68, 14, 14], expected_numbers
  # end

  def test_difference_between_expected_and_actual
    nr = NumberRotater.new
    expected = [14, 14, 69, 78, 68, 14, 14]
    actual = [83, 1, 41, 25, 46, 1, 77]
    # key = 63673 date = 261015
    difference = nr.subtract(actual, expected)
    assert_equal [69, -13, -28, -53, -22, -13, 63], difference
  end

  def test_reduced_differences
    nr = NumberRotater.new
    differences = [69, -13, -28, -53, -22, -13, 63]
    reduced = nr.reduce(differences)
    assert_equal [69, 78, 63, 38, 69, 78, 63], reduced
  end

  def test_arrange_order
    c = KeyCrack.new
    message = "hello, how are you? ..end.."
    reduced_differences = [69, 78, 63, 38, 69, 78, 63]
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
