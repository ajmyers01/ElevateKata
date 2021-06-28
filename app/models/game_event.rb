# frozen_string_literal: true

class GameEvent < ApplicationRecord
  belongs_to :game
  belongs_to :user
end
