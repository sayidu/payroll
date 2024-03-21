class Timesheet < ApplicationRecord
  validates :filename, uniqueness: {  message: "Provide a file that is yet to be uploaded." }

  has_many :timesheet_logs
end
