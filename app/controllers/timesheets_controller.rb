# frozen_string_literal: true

class TimesheetsController < ApplicationController
  def new
    @timesheet = Timesheet.new
  end

  def create
    result = Timesheets::ImportService.new(timesheet_params[:filename]).call
    if result.success
      flash[:info] = "Timesheet #{result.object.filename} was imported successfully"
    else
      flash[:danger] = "Failed to import the timesheet: #{result.errors}"
    end
    redirect_to action: :new
  end

  private

  def timesheet_params
    params.require(:timesheet).permit(:filename)
  end
end
