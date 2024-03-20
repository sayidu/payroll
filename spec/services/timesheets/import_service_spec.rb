# frozen_string_literal: true

require 'rails_helper'

describe Timesheets::ImportService do
  let(:timelog_file) { 'spec/fixtures/log_sample.csv' }

  subject { described_class.new(Rack::Test::UploadedFile.new(timelog_file)) }

  describe '#call' do
    context 'uploads a work timesheet log' do
      it 'processes timesheet file and logs' do
        create(:job_group, name: 'A', pay: 20)
        create(:job_group, name: 'B', pay: 30)

        subject.call

        expect(Timesheet.count).to eq(1)
        expect(TimesheetLog.count).to eq(4)
      end
    end
  end
end
