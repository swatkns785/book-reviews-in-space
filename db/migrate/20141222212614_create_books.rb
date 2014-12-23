class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author
      t.string :url, null: false
      t.integer :user_id, null: false
    end
  end
end
