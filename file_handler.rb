class FileHandler
  def read_file(file_name)
    file_content = File.read(file_name)
    binding.pry
    puts "File loaded."
    return file_content
  end

  def write_file(file_name, string)
    file = File.new(file_name, "w")
    file.write(string)
    puts "File written."
    file.close
  end
end
