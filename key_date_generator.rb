class KeyDateGenerator

  def generate_key
    rand(10000..99999)
  end

  def generate_date
    Time.now.strftime("%d%m%y")
  end

end
