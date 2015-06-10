class CreateUsersBooks < ActiveRecord::Migration
  def change
    create_table :users_books do |t|
      t.integer :user_id
      t.integer :book_id

      t.timestamps null: false
    end
  end
end
