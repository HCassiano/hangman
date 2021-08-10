class AddRevisedToRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :records, :revised, :boolean
    change_column_null :records, :revised, false
    change_column_default :records, :revised, false
  end
end
