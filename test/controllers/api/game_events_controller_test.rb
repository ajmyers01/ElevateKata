# frozen_string_literal: true

require 'test_helper'

module Api
  class GameEventsControllerTest < ActionDispatch::IntegrationTest
    def setup
      @user = users(:one)
      @game = games(:one)
    end

    test "index" do 
      login(@user)

      assert_difference("@user.games.count",1) do 

        post "/api/user/game_events", 
        params: {
          event_type: "completed",
          occured_at: DateTime.now,
          game_id: @game.id
        },
        headers: {'HTTP_AUTHORIZATION': "Bearer #{@token}" }
      end

    end
  end
end
