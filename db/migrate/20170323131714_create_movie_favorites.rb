class CreateMovieFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :movie_favorites do |t|
      t.integer :movie_id
      t.integer :user_id

      t.timestamps
    end
  end
end
