JsonWebToken.configure(
  secret_key_base: Rails.application.credentials.secret_key_base,
  token_live_time: 1.day
)
