class AddUniqueIndexToTimesheets < ActiveRecord::Migration[7.0]
  def change
    add_index :timesheets, :filename, unique: true
  end
end
