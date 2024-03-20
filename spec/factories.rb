FactoryBot.define do
  factory(:employee) do
    public_id { rand(100) }
  end

  factory(:job_group) do
    name { 'A' }
    pay { 20 }
  end

  factory(:timesheet) do
    filename { 'xx' }
  end

  factory(:timesheet_log) do
    hours_worked { 20 }
  end
end
