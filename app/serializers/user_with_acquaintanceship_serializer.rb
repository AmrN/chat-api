class UserWithAcquaintanceshipSerializer < UserSerializer
  attributes :acquaintanceship

  def acquaintanceship
    if current_user && current_user != object
      acq = current_user.acquaintanceships.find_by(
        acquaintance_id: object.id)

      acq
    else
      nil
    end

  end
end
