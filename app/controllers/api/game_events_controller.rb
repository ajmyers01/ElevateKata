# frozen_string_literal: true

module Api
  class GameEventsController < ApplicationController
    before_action :authorized

    def create
      @game_event = GameEvent.new(game_event_params)
      @game_event.user_id = @user.id

      if @game_event.valid?
        @game_event.save
        render json: { game_event: @game_event }, status: :created
      else
        render json: { error: @game_event.errors.messages }
      end
    end

    private

    def game_event_params
      params.permit(:event_type, :occured_at, :game_id, :user_id)
    end
  end
end
