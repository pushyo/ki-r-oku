class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :pwd_hashcode
      t.string :salt

      t.timestamps
    end
  end
end
