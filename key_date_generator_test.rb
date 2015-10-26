require 'minitest/autorun'
require 'pry'
require './key_date_generator'

class KeyDateGeneratorTest < Minitest::Test

  def test_key_gen_returns_five_digit_key
    gen = KeyDateGenerator.new
    key = gen.generate_key
    assert_equal 5, key.to_s.chars.length
  end

  def test_date_gen_returs_six_digit_date
    # is there a way to test this more accurately? difficult to hard-code a test for an ever-changing value.
    gen = KeyDateGenerator.new
    date = gen.generate_date
    assert_equal 6, date.chars.length
  end
end
