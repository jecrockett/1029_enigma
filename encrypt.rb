require './file_handler'
require './enigma'
require 'pry'

file_handler = FileHandler.new
unencrypted_message = file_handler.read_file("#{ARGV[0]}").chomp

if ARGV[2]
  binding.pry
  key = file_handler.read_file(ARGV[2]).to_i
  binding.pry
else
  key = nil
end

if ARGV[3]
  date = file_handler.read_file(ARGV[3])
else
  date = nil
end

e = Enigma.new
encrypted_message = e.encrypt(key, date, unencrypted_message)
file_handler.write_file(ARGV[1], encrypted_message)
