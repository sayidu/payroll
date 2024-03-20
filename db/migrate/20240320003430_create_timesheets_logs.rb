class CreateTimesheetsLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :timesheets_logs do |t|
      t.datetime :date
      t.integer :hours_worked
      t.references :employee
      t.references :job_group
      t.references :timesheet

      t.timestamps
    end
  end
end
