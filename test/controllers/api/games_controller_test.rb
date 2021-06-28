# frozen_string_literal: true

require 'test_helper'

module Api
  class GamesControllerTest < ActionDispatch::IntegrationTest
    def setup
      @user = users(:one)
    end

    test "index" do 
      login(@user)

      get "/api/games", headers: {'HTTP_AUTHORIZATION': "Bearer #{@token}" }

      json_response = JSON.parse(response.body)
      assert_equal Game.all.count, json_response["games"].count 
    end
  end
end
