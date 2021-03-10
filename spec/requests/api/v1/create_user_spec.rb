require "rails_helper"

describe "Create a new user ",type: :request do

  describe "(happy path)" do
    it "should create a post from a json body" do
      email = "me@example.com"
      password = "IWillNeverGetHacked123"
      payload = {
        email: email,
        password: password,
        password_confirmation: password
      }

      post "/api/v1/users", params: payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

      expect(response).to be_successful
    end
  end

  describe "(sad path)" do
    it "should fail with a 404 bad request error if non json format is sent" do
      email = "me@example.com"
      password = "IWillNeverGetHacked123"

      post "/api/v1/users?email=#{email}&password=#{password}&password_confirmation=#{password}"

      expect(response.status).to eq(404)
      expect(response.body).to eq("{\"error\":\"bad request\"}")
    end

    it "should fail with a 400 containing appropriate errors if bad credentials are passed" do
      email = "me@example.com"
      password = "IWillNeverGetHacked123"
      not_password = "bleh"
      mismatch_password_payload = {
        email: email,
        password: password,
        password_confirmation: not_password
      }

      blank_credentials_payload = {
        email: email,
      }

      post "/api/v1/users", params: mismatch_password_payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      expect(response.status).to eq(400)

      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:errors]).to eq(["Password confirmation doesn't match Password"])

      post "/api/v1/users", params: blank_credentials_payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      expect(response.status).to eq(400)

      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:errors]).to eq(["Password can't be blank", "Password confirmation can't be blank"])
    end
  end
end
