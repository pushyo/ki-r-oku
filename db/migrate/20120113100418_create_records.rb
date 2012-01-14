class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :title
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    add_index :records, :user_id
  end
end
