# frozen_string_literal: true

module Api
  class GamesController < ApplicationController
    before_action :authorized

    def index
      @games = Game.all
      render json: { games: @games }
    end
  end
end
