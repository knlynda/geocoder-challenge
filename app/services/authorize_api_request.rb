class AuthorizeApiRequest
  def initialize(headers = {})
    @auth_token = parse_auth_token(headers)
    @user_id = parse_user_id(auth_token)
  end

  def call
    User.find_by(id: user_id)
  end

  private

  attr_reader :auth_token, :user_id

  def parse_user_id(auth_token)
    ::JsonWebToken.decode(auth_token).try(:[], :user_id)
  end

  def parse_auth_token(headers)
    headers['Authorization']&.split(' ')&.last
  end
end
