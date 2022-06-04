class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: {to_table: 'users'}, index: true
      t.string :title
      t.string :h_one
      t.text :p_one
      t.string :h_two
      t.text :p_two
      t.string :h_three
      t.text :p_three
      t.text :conclusion
      t.string :photo_one
      t.string :photo_two
      t.integer :comments_counter, default: 0, null: false
      t.integer :likes_counter, default: 0, null: false
      t.timestamps
    end
  end
end
