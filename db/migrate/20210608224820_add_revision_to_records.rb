class AddRevisionToRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :records, :revision, :boolean
  end
end
