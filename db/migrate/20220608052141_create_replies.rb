class CreateReplies < ActiveRecord::Migration[7.0]
  def change
    create_table :replies do |t|
      t.references :comment, null: false, foreign_key: {to_table: 'comments'}, index: true
      t.text :reply
      t.string :author
      t.string :avatar
      t.timestamps
    end
  end
end
