class Api::GamesController < ApplicationController
  before_action :authorized

  def index
    @games = Game.all
    render json: {games: @games}
  end
end
