class Api::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    @user = User.create(user_params)

    if @user.valid?
      token = encode_token({user_id: @user.id})
      render json: {token: token}, status: :created
    else
      render json: {error: @user.errors.messages}
    end
  end

  def show
    render json: @user.as_json(only: [:id, :username, :email, :full_name], methods: [:stats]) 
  end

  private

  def user_params
    params.permit(:email, :username, :full_name, :password, :password_confirmation)
  end

end
