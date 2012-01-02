class FixColumnName < ActiveRecord::Migration
  def up
    rename_column :users, :pwd_hashcode, :password_digest
  end

  def down
  end
end
