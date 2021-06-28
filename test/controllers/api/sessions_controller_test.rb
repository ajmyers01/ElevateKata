# frozen_string_literal: true

require 'test_helper'

module Api
  class SessionsControllerTest < ActionDispatch::IntegrationTest
    def setup
      @user = users(:one)
    end

    test "login" do 
      post "/api/sessions", 
      params: {  
          username: @user.username, 
          password: "Password1!", 
      }

      json_response = JSON.parse(response.body)

      assert json_response["token"].present? 
    end

    test "bad login" do 
      post "/api/sessions", 
      params: {  
          username: @user.username, 
          password: "WrongPassword!", 
      }

      json_response = JSON.parse(response.body)

      assert_equal json_response["error"], "Invalid username or password"
    end
  end
end
