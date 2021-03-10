require "rails_helper"
describe "User login", type: :request do
  describe "(happy path)" do
    it "returns user email with a key when proper credentials are provided" do

      email = "me@example.com"
      password = "IWillNeverGetHacked123"
      not_password = "bleh"
      payload = {
        email: email,
        password: password,
        password_confirmation: password
      }
      user = User.create(email: email, password: password, password_confirmation: password)

      post "/api/v1/sessions", params: payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      expect(response).to be_successful
      expect(response.status).to eq(200)

      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:type]).to eq("users")
      expect(parsed[:data][:id]).to eq(user.id.to_s)
      expect(parsed[:data][:attributes][:email]).to eq(user.email)
      expect(parsed[:data][:attributes][:api_key]).to be_a String

    end
  end

  describe "(sad path)" do
    it "should fail with a 404 bad request error if no body is sent" do
      email = "me@example.com"
      password = "IWillNeverGetHacked123"
      user = User.create(email: email, password: password, password_confirmation: password)

      post "/api/v1/users?email=#{email}&password=#{password}&password_confirmation=#{password}"

      expect(response.status).to eq(404)
      expect(response.body).to eq("{\"error\":\"bad request\"}")
    end

    it "should fail with a 401 containing appropriate errors if bad credentials are passed" do

      email = "me@example.com"
      password = "IWillNeverGetHacked123"
      user = User.create(email: email, password: password, password_confirmation: password)

      not_password = "bleh"
      mismatch_password_payload = {
        email: email,
        password: not_password,
      }

      blank_credentials_payload = {
        email: email,
      }

      post "/api/v1/sessions", params: mismatch_password_payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      expect(response.status).to eq(401)

      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:error]).to eq("bad credentials")

      post "/api/v1/sessions", params: blank_credentials_payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      expect(response.status).to eq(401)

      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:error]).to eq("bad credentials")
    end
  end
end
