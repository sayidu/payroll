Rails.application.routes.draw do
  resources :timesheets
  root "timesheet#new"

  resources :timesheets, only: [:new, :create]
  resources :payroll_reports, only: :create
end

# rails generate model Employee public_id:integer
# rails generate model JobGroup name:string pay:integer
# rails generate model Timesheets date:datetime hours_worked:integer employee:reference job_group:reference