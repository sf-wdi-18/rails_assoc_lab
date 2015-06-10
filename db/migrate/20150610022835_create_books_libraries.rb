class CreateBooksLibraries < ActiveRecord::Migration
  def change
    create_table :books_libraries do |t|
      t.integer :book_id
      t.integer :library_id

      t.timestamps null: false
    end
  end
end
