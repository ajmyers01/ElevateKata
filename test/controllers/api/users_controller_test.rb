# frozen_string_literal: true

require 'test_helper'

module Api
  class UsersControllerTest < ActionDispatch::IntegrationTest
    def setup
      @user = users(:one)
    end

    test 'Signup' do
      assert_difference('User.count', 1) do
        post '/api/users',
             params: {
               email: 'unique@gmail.com',
               username: 'uniquename',
               full_name: 'unique name',
               password: 'tester1',
               password_confirmation: 'tester1'
             }

        json_response = JSON.parse(response.body)
      end
    end

    test 'bad create' do
      assert_no_difference('User.count') do
        post '/api/users',
             params: {
               email: 'uniqlue@gmail.com',
               username: 'uniqulename',
               full_name: 'unique name',
               password: 'tester',
               password_confirmation: 'tester1'
             }

        json_response = JSON.parse(response.body)
      end
    end

    test 'Show' do
      login(@user)

      get '/api/user', headers: { 'HTTP_AUTHORIZATION': "Bearer #{@token}" }

      json_response = JSON.parse(response.body)
      assert_equal @user.email, json_response['email']
      assert_equal @user.username, json_response['username']
      assert_equal @user.full_name, json_response['full_name']

      assert_equal @user.total_games_played, json_response['stats']['total_games_played']
      assert_equal @user.total_math_games_played, json_response['stats']['total_math_games_played']
      assert_equal @user.total_reading_games_played, json_response['stats']['total_reading_games_played']
      assert_equal @user.total_speaking_games_played, json_response['stats']['total_speaking_games_played']
      assert_equal @user.total_writing_games_played, json_response['stats']['total_writing_games_played']
    end
  end
end
