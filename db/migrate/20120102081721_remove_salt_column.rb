class RemoveSaltColumn < ActiveRecord::Migration
  def up
    remove_column :users, :salt
  end

  def down
  end
end
