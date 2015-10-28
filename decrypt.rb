require './file_handler'
require './enigma'
require 'pry'

file_handler = FileHandler.new
encrypted_message = file_handler.read_file("#{ARGV[0]}").chomp

if ARGV[2]
  key = ARGV[2].to_i
else
  key = nil
end

if ARGV[3]
  date = ARGV[3]
else
  date = nil
end

e = Enigma.new
decrypted_message = e.decrypt(key, date, encrypted_message)
file_handler.write_file(ARGV[1], decrypted_message)
