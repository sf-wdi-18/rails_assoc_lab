class ChangeIsbnColumnType < ActiveRecord::Migration
  def change
    change_table :books do |t|
      t.change :isbn, :string
    end
  end
end
