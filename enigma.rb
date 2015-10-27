require './key_date_generator'
require './offset_generator'
require './message_converter'
require './number_rotater'
require './crack'

class Enigma

  def encrypt(key=nil, date=nil, message)
    create_objects
    @key = check_key(key)
    check_date(date)
    puts "Key = #{@key} | Date = #{@date}"
    encrypt_message(@key, @date, message)
  end

  def decrypt(key, date=nil, message)
    create_objects
    check_date(date)
    decrypt_message(key, @date, message)
  end

  def crack(date=@date, message)
    create_objects
    check_date(date)
    date_offsets = @og.generate_date_offsets(date)
    final_offsets = @c.final_offsets(message)
    key_offsets = @nr.subtract(final_offsets, date_offsets)
    key = @c.key(key_offsets)
    decrypt(key, @date, message)
  end

  def create_required_objects
    @kdg = KeyDateGenerator.new
    @og = OffsetGenerator.new
    @mc = MessageConverter.new
    @nr = NumberRotater.new
    @c = KeyCrack.new
  end

  def check_key(key)
    if key.nil?
      @kdg.generate_key
    else
      key
    end
  end

  def check_date(date)
    if date.nil?
      @date = @kdg.generate_date
    else
      @date = date
    end
  end

  def encrypt_message(key, date, message)
    offsets = @og.offsets(key, date)
    numbers = @mc.convert_to_numbers(message)
    rotated_numbers = @nr.encryption_rotation(numbers, offsets)
    @mc.convert_to_letters(rotated_numbers)
  end

  def decrypt_message(key, date, message)
    offsets = @og.offsets(key, date)
    numbers = @mc.convert_to_numbers(message)
    rotated_numbers = @nr.decryption_rotation(numbers, offsets)
    @mc.convert_to_letters(rotated_numbers)
  end



end
