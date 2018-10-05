module JsonWebToken
  class << self
    attr_reader :secret_key_base, :token_live_time

    def configure(secret_key_base:, token_live_time:)
      @secret_key_base = secret_key_base
      @token_live_time = token_live_time
    end

    def encode(payload)
      payload = payload.merge(exp: token_live_time.from_now.to_i)
      JWT.encode(payload, secret_key_base)
    rescue JWT::EncodeError
      nil
    end

    def decode(token)
      payload = JWT.decode(token, secret_key_base).first
      payload.try(:with_indifferent_access)
    rescue JWT::DecodeError
      {}
    end
  end
end
