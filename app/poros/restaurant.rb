class Restaurant
  attr_reader :city_state, :name, :address
  def initialize(data)
    @city_state = data[:location][:city] + ", " + data[:location][:state]
    @name = data[:name]
    @address = data[:location][:display_address] * ', '
  end
end
