# frozen_string_literal: true

require 'csv'

module Timesheets
  class ImportService
    def initialize(log_file)
      @log_file = log_file
    end

    def call
      tempfile = log_file.tempfile
      timesheet = Timesheet.create(filename: File.basename(tempfile.path, '.*'))
      timesheet.with_lock do
        process_file(timesheet, tempfile)
        result(success: true)
      rescue StandardError # TO DO: Resuce precise errors
        result(success: false)
      end
    end

    private

    attr_reader :log_file

    def process_file(timesheet, tempfile)
      ::CSV.parse(File.read(tempfile), headers: true).map do |row|
        employee = Employee.find_or_create_by(public_id: format(row['employee id']))
        job_group = JobGroup.find_by_name(format(row['job group']))

        # TO DO: ActiveImport to bulk import at once
        TimesheetLog.create!(
          employee:, job_group:, timesheet:,
          date: format(row['date']), hours_worked: format(row['hours worked'])
        )
      end
    end

    def result(success: true, message: '')
      OpenStruct.new(message:, success:)
    end

    def format(value)
      value.to_s.strip
    end
  end
end
