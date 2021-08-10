class ChangeRecordsRevised < ActiveRecord::Migration[6.1]
  def change
    change_column :records, :revision, :boolean
  end
end
