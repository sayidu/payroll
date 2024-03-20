# frozen_string_literal: true

require 'rails_helper'

describe PayrollReports::GenerateService do
  let(:employee_one) { create(:employee, public_id: 1) }
  let(:employee_two) { create(:employee, public_id: 2) }
  let(:job_group_one) { create(:job_group, pay: '30') }
  let(:job_group_two) { create(:job_group, pay: '20') }
  let(:timesheet) { create(:timesheet) }

  describe '#call' do
    context 'uploads a work timesheet log' do
      it 'processes timesheet file and logs' do
        eo_time_log = create(:timesheet_log, hours_worked: 10, employee: employee_one, job_group: job_group_one, timesheet:, date: Date.today.beginning_of_month)
        create(:timesheet_log, hours_worked: 4, employee: employee_one, job_group: job_group_two, timesheet:, date: Date.today.end_of_month)
        etwo_time_log = create(:timesheet_log, hours_worked: 3, employee: employee_two, job_group: job_group_one, timesheet:, date: Date.today.end_of_month)

        payroll_result = described_class.new.generate
        employee_results = payroll_result[:payrollReport][:employeeReports]
   
        expect(employee_results.first[:employeeId]).to eq(employee_one.public_id)
        expect(employee_results.first[:amountPaid]).to eq(format_money(eo_time_log.hours_worked * job_group_one.pay))
        expect(employee_results.last[:employeeId]).to eq(employee_two.public_id)
        expect(employee_results.last[:amountPaid]).to eq(format_money(etwo_time_log.hours_worked * job_group_one.pay))
      end
    end
  end

  def format_money(pay)
    "$#{pay.to_f.round(2)}"
  end
end
