class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :first_name
      t.string :last_name
      t.integer :y_o_b
      t.integer :y_o_d

      t.timestamps
    end
  end
end
