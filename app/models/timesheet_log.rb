class TimesheetLog < ApplicationRecord
  belongs_to :employee
  belongs_to :timesheet
  belongs_to :job_group
end
