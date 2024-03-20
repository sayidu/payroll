class CreateJobGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :job_groups do |t|
      t.string :name
      t.integer :pay

      t.timestamps
    end
  end
end
