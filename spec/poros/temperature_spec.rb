require "rails_helper"

describe Temperature do
  it "exists and has attributes" do
    value = 280
    temp = Temperature.new(value)

    expect(temp).to be_a Temperature
    expect(temp.kelvin).to eq(value)
    expect(temp.fahrenheit).to eq(44.33000000000004)
  end
end
