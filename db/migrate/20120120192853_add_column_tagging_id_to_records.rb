class AddColumnTaggingIdToRecords < ActiveRecord::Migration
  def change
    add_column :records, :tagging_id, :integer
  end
end
