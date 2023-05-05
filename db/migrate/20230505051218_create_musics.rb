class CreateMusics < ActiveRecord::Migration[6.1]
  def change
    create_table :musics do |t|
      
      t.integer :user_id, null: false
      t.integer :music_genre_id, null: false
      t.string :music_name, null: false
      t.text :music_notes, null: false
      t.string :singer, null: false

      t.timestamps
    end
  end
end
