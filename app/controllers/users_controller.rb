class UsersController < ApplicationController
  # see http://api.rubyonrails.org/classes/ActionController/ParamsWrapper.html
  wrap_parameters include: User.attribute_names + [:password, :password_confirmation]

  before_action :authenticate, only: [:index, :current]
  before_action :set_user, only: [:show, :update, :destroy, :acquaintanceship, :friends]

  # GET /users
  def index
    @users = User.all
    byebug
    render json: @users
  end

  # GET /users/1
  def show
    # if current_user == @user
      render json: @user, serializer: UserWithAcquaintanceshipSerializer
    # else
    #   head :unauthorized
    # end
  end

  # POST /users
  def create
    # byebug
    @user = User.new(user_params)
    if @user.save
      serializer = @user.guest? ? UserWithJwtSerializer : UserSerializer
      render json: @user, status: :created, location: @user, serializer: serializer
    else
      render json: {errors: @user.errors}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: {errors: @user.errors}, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    head :no_content # 204
    # byebug
  end

  def current
    render json: current_user
  end

  def friends
    friends = @user.friends.all
    render json: friends, serializer: ActiveModel::Serializer::ArraySerializer, each_serializer: UserWithAcquaintanceshipSerializer
  end

  def acquaintanceship
    if current_user == @user
      @acquaintanceship = nil
    else
      @acquaintanceship = current_user.add_or_get_acquaintance(@user)
    end
    render json: @acquaintanceship
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
