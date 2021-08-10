class CreateRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :records do |t|
      t.string :word
      t.integer :victories
      t.integer :defeats

      t.timestamps
    end
end
