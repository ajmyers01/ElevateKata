class CreateGameEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :game_events do |t|
      t.belongs_to :user
      t.belongs_to :game
      t.datetime :occured_at
      t.string :event_type

      t.timestamps
    end
  end
end
