class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.integer :publication_year
      t.string :isbn
      t.integer :author_id

      t.timestamps
    end
  end
end
