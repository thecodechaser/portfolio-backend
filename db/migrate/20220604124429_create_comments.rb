class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :post, null: false, foreign_key: {to_table: 'posts'}, index: true
      t.text :comment
      t.string :author
      t.string :avatar
      t.timestamps
    end
  end
end
