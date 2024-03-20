FactoryBot.define do
  factory(:employee) do
    email { rand(100) }
  end

  factory(:job_group) do
    name { 'A' }
    pay { '20'}
  end
end
