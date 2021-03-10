require "rails_helper"

describe JsonWebToken do
  it "can encode and decode tokens" do
    num = 7
    token = JsonWebToken.encode(user_id: num)
    decoded_hash = JsonWebToken.decode(token)
    expect(decoded_hash[:user_id]).to eq(num)
  end
end
