class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :post, null: false, foreign_key: {to_table: 'posts'}, index: true
      t.timestamps
    end
  end
end
