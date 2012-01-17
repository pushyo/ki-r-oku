class AddWordCountToRecords < ActiveRecord::Migration
  def change
    add_column :records, :word_count, :string
  end
end
