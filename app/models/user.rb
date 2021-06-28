# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :game_events
  has_many :games, through: :game_events
  validates_presence_of :email, :username, :full_name, :password, :password_confirmation
  validates_uniqueness_of :username

  def stats
    {
      total_games_played: total_games_played,
      total_math_games_played: total_math_games_played,
      total_reading_games_played: total_reading_games_played,
      total_speaking_games_played: total_speaking_games_played,
      total_writing_games_played: total_writing_games_played
    }
  end

  def total_games_played
    games.count
  end

  def total_math_games_played
    games.where(category: 'Math').count
  end

  def total_reading_games_played
    games.where(category: 'Reading').count
  end

  def total_speaking_games_played
    games.where(category: 'Speaking').count
  end

  def total_writing_games_played
    games.where(category: 'Writing').count
  end
end
