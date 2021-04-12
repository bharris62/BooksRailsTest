
class AuthenticationTokenService
  HMAC_SECRET = 'my$uper$3cretP455'
  ALGORITHM_TYPE = 'HS256'

  def self.call(user_id)
    payload = {
      user_id: user_id
    }
    token = JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
  end

  def self.decode

  end
end