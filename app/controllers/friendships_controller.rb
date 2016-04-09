class FriendshipsController < ApplicationController
  before_action :authenticate
  before_action :set_user
  before_action :ensure_not_current_user
  before_action :set_acquaintanceship, only: [:create, :destroy]

  # POST /acquaintances
  def create
    @acquaintanceship.update(friend: true)
    render json: @user, serializer: UserWithAcquaintanceshipSerializer
  end

  def destroy
    @acquaintanceship.update(friend: false)
    render json: @user, serializer: UserWithAcquaintanceshipSerializer
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:user_id])
    end

    def ensure_not_current_user
      if current_user == @user
        head :unprocessable_entity
      end
    end

    def set_acquaintanceship
      @acquaintanceship = current_user.add_or_get_acquaintance(@user)
    end
end
