require 'minitest/autorun'
require 'pry'
require './enigma'

class EnigmaTest < Minitest::Test

  def test_encrypt
    e = Enigma.new
    encrypted_message = e.encrypt(12345, 311015, "boston")
    assert_equal "n-<K ,", encrypted_message
  end

  def test_decrypt
    e = Enigma.new
    decrypted_message = e.decrypt(12345, 311015, "n-<K ,")
    assert_equal "boston", decrypted_message
  end
