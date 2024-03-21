# frozen_string_literal: true

require 'csv'

module Timesheets
  class ImportService
    def initialize(timesheet_file)
      @timesheet = Timesheet.new
      @timesheet_file = timesheet_file
    end

    def call
      tempfile = timesheet_file.tempfile
      timesheet.transaction do
        timesheet.filename = timesheet_file.original_filename
        timesheet.save!
        process_file(timesheet, tempfile)
        result(success: true, object: timesheet)
      rescue StandardError => e # TO DO: Rescue precise errors
        result(success: false, errors: e)
      end
    end

    private

    attr_reader :timesheet, :timesheet_file

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

    def result(success: true, object: nil, errors: '')
      OpenStruct.new(success:, object:, errors:)
    end

    def format(value)
      value.to_s.strip
    end
  end
end
