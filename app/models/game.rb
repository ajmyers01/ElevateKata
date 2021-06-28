# frozen_string_literal: true

class Game < ApplicationRecord
  has_many :game_events
  has_many :users, through: :game_events
end
