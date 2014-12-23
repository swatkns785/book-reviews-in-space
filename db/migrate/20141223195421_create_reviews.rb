class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :description, null: false
      t.integer :user_id, null: false
      t.integer :book_id, null: false
    end
  end
end
