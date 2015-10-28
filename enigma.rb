require './key_date_generator'
require './offset_generator'
require './message_converter'
require './number_rotater'
require './key_crack'

class Enigma

  def encrypt(key=nil, date=nil, message)
    key = check_key(key)
    date = check_date(date)
    puts "Key = #{key} | Date = #{date}"
    encrypt_message(key, date, message)
  end

  def decrypt(key, date=nil, message)
    date = check_date(date)
    puts "Key = #{key} | Date = #{date}"
    decrypt_message(key, date, message)
  end

  def crack(date=nil, message)
    date = check_date(date)
    key = crack_key(date, message)
    puts "Cracked Key = #{key} | Date = #{date}"
    decrypt_message(key, date, message)
  end

  def check_key(key)
    if key.nil?
      kdg = KeyDateGenerator.new
      kdg.generate_key
    else
      key
    end
  end

  def check_date(date)
    if date.nil?
      kdg = KeyDateGenerator.new
      kdg.generate_date
    else
      date
    end
  end

  def encrypt_message(key, date, message)
    og = OffsetGenerator.new
    mc = MessageConverter.new
    nr = NumberRotater.new
    offsets = og.offsets(key, date)
    numbers = mc.convert_to_numbers(message)
    rotated_numbers = nr.encryption_rotation(numbers, offsets)
    mc.convert_to_letters(rotated_numbers)
  end

  def decrypt_message(key, date, message)
    og = OffsetGenerator.new
    mc = MessageConverter.new
    nr = NumberRotater.new
    offsets = og.offsets(key, date)
    numbers = mc.convert_to_numbers(message)
    rotated_numbers = nr.decryption_rotation(numbers, offsets)
    mc.convert_to_letters(rotated_numbers)
  end

  def crack_key(date, message)
    c = KeyCrack.new
    og = OffsetGenerator.new
    mc = MessageConverter.new
    nr = NumberRotater.new
    date_offsets = og.generate_date_offsets(date)
    end_of_message = c.extract_ending(message)
    expected_ending = [14, 14, 69, 78, 68, 14, 14]
    actual_ending = mc.convert_to_numbers(end_of_message)
    c.interpret_key(actual_ending, expected_ending, message, date_offsets)
  end
end
