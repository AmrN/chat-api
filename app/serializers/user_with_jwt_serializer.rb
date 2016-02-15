class UserWithJwtSerializer < UserSerializer
  attribute :jwt

  def jwt
    auth_token.token
  end

  def auth_token
     Knock::AuthToken.new payload: { sub: object.id }
  end
end
