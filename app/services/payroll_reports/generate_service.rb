# frozen_string_literal: true

module PayrollReports
  class GenerateService
    FIRST_DAY = '01'
    LAST_DAY = '31'
    PAY_DAY_CUTOFF = 15

    def initialize(month: Time.now.month)
      @month = month
      @limit = 1000
    end

    def generate
      payroll_data = []
      timesheet_logs = TimesheetLog.where(date: (Date.today.beginning_of_month..Date.today.end_of_month))

      employee_job_group_logs = timesheet_logs.group_by do |log|
        [log.employee_id, log.job_group_id, log.date.day <= 15 ? '1st_half' : '2nd_half']
      end

      # Calculate amount paid based on hours worked and job group rates
      employee_job_group_logs.each do |(employee_id, job_group_id, pay_period), logs|
        total_hours = logs.sum(&:hours_worked)
        employee = Employee.find(employee_id)
        job_group = JobGroup.find(job_group_id)
        amount_paid = (total_hours * job_group.pay).to_f.round(2)
        start_date = pay_period == '1st_half' ? Date.today.beginning_of_month : Date.today.beginning_of_month + 15.days
        end_date = pay_period == '1st_half' ? Date.today.beginning_of_month + 14.days : Date.today.end_of_month

        payroll_data << {
          employeeId: employee.public_id,
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

    attr_reader :month
  end
end
