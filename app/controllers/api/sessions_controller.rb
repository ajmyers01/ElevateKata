# frozen_string_literal: true

module Api
  class SessionsController < ApplicationController
    skip_before_action :authorized, only: [:login]

    def login
      @user = User.find_by(username: params[:username])

      if @user&.authenticate(params[:password])
        token = encode_token({ user_id: @user.id })
        render json: { token: token }
      else
        render json: { error: 'Invalid username or password' }
      end
    end

    private

    def user_params
      params.permit(:username, :password, :password_confirmation)
    end
  end
end
