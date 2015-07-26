# Add to json of UserSerializer
class CurrentUserSerializer < UserSerializer
  attributes :details

  def details
    'Details you only get if this is the current_user' if current_user
  end
end
