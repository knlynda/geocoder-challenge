class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    return unless user&.authenticate(password)

    ::JsonWebToken.encode(user_id: user.id)
  end

  private

  attr_reader :email, :password

  def user
    @user ||= User.find_by(email: email)
  end
end
