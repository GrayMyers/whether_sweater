class JsonWebToken
  class << self
    def encode(info, created_at = Time.now) #used to generate multiple unique api keys
      JWT.encode(info, Rails.application.secrets.secret_key_base)
    end

    def decode(token)
      JWT.decode(token, Rails.application.secrets.secret_key_base)[0].symbolize_keys
    rescue
      {}
    end
  end
end
