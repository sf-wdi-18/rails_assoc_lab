class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :description
      t.integer :publication_year
      t.integer :isbn
      t.integer :author_id

      t.timestamps null: false
    end
  end
end
