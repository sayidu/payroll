# frozen_string_literal: true

module PayrollReports
  class GenerateService
    FIRST_DAY = '01'
    LAST_DAY = '31'
    PAY_DAY_CUTOFF = 15

    def initialize(month, year)
      @month = (month.presence || Time.now.month).to_i
      @year = (year.presence || Time.now.year).to_i
      @limit = 1000
    end

    def generate
      payroll_data = []
      month_start_date = Date.new(year, month, 1)
      month_end_date = Date.new(year, month, -1)
      timesheet_logs = TimesheetLog.where(date: (month_start_date..month_end_date))
      employee_job_group_logs = timesheet_logs.group_by do |log|
        [log.employee_id, log.job_group_id, log.date.day <= 15 ? '1st_half' : '2nd_half']
      end

      # Calculate amount paid based on hours worked and job group rates
      employee_job_group_logs.each do |(employee_id, job_group_id, pay_period), logs|
        total_hours = logs.sum(&:hours_worked)
        employee = Employee.find(employee_id)
        job_group = JobGroup.find(job_group_id)
        amount_paid = (total_hours * job_group.pay).to_f.round(2)
        start_date = pay_period == '1st_half' ? month_start_date : month_start_date + 15.days
        end_date = pay_period == '1st_half' ? month_start_date + 14.days : month_end_date

        payroll_data << {
          employeeId: employee.public_id.to_s,
          payPeriod: {
            startDate: start_date.strftime('%Y-%m-%d'),
            endDate: end_date.strftime('%Y-%m-%d')
          },
          totalHoursWorked: total_hours,
          amountPaid: "$#{amount_paid}"
        }
      end

      { payrollReport: { employeeReports: payroll_data } }
    end

    private

    attr_reader :month, :year
  end
end
