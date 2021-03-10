require "rails_helper"

describe JsonWebToken do
  it "can encode and decode tokens" do
    num = 7
    token = JsonWebToken.encode(user_id: num)
    decoded_hash = JsonWebToken.decode(token)
    expect(decoded_hash[:user_id]).to eq(num)
  end

  it "returns an empty hash when an invalid token is provided" do
    token = "This is not a token"
    decoded_hash = JsonWebToken.decode(token)
    expect(decoded_hash).to eq({})
  end
end
