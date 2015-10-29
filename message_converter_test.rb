require 'minitest/autorun'
require 'pry'
require './message_converter'

class MessageConverterTest < Minitest::Test

  def test_full_index_length
    mc = MessageConverter.new
    index = mc.full_index
    assert_equal 91, index.length
  end

  def test_full_index_accuracy
    mc = MessageConverter.new
    index = mc.full_index
    assert_equal " ", index[0]
    assert_equal "R", index[50]
  end

  def test_convert_message_to_numbers
    mc = MessageConverter.new
    test_phrase = "boston"
    converted_message = mc.convert_to_numbers(test_phrase)
    assert_equal [66, 79, 83, 84, 79, 78], converted_message
  end

  def test_convert_message_with_numbers_and_symbols
    mc = MessageConverter.new
    test_phrase = "%4 7*+"
    converted_message = mc.convert_to_numbers(test_phrase)
    assert_equal [5, 20, 0, 23, 10, 11], converted_message
  end

  # reduced array (each % 91) will be passed in, so numbers will never be negative.

  def test_convert_numbers_to_letters
    mc = MessageConverter.new
    test_array = [66, 79, 83, 84, 79, 78]
    converted_message = mc.convert_to_letters(test_array)
    assert_equal "boston", converted_message
  end

  def test_expected_final_numbers_for_crack
    mc = MessageConverter.new
    message = "..end.."
    expected_numbers = mc.convert_to_numbers(message)
    assert_equal [14, 14, 69, 78, 68, 14, 14], expected_numbers
  end

end
