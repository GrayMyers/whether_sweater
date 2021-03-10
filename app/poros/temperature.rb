class Temperature
  attr_reader :kelvin, :fahrenheit
  def initialize(temp)
    @kelvin = temp
    @fahrenheit = k_to_f(temp)
  end

  private

  def k_to_f(temp)
    (temp - 273.15) * 9/5 + 32
  end
end
