class TimesheetsController < ApplicationController
  def new
  end

  def create
    result = Timesheets::ImportService.new(import_params).call
    if result.success
      flash[:info] = 'Timesheet #name was imported successfully'
    else
      flash[:danger] = 'Failed to import the timesheet'
    end
  end
end
