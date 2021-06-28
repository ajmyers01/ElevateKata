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
      total_writing_games_played: total_writing_games_played,
      current_streak_in_days: current_streak_in_days
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

  def current_streak_in_days
    streak_count = 0
    today = DateTime.now

    dates_array = game_events.order('occured_at DESC').map do |ge|
      ge.occured_at.to_date
    end
    dates_array.uniq!

    streak_count += 1 if dates_array.include?(Date.today)
    i = 1

    loop do
      if dates_array.include?(Date.today - i.days)
        i += 1
        streak_count += 1
      else
        break
      end
    end

    streak_count
  end
end
