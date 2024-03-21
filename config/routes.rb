Rails.application.routes.draw do
  root "timesheets#new"

  resources :timesheets, only: [:new, :create]
  resources :payroll_reports, only: :create
end
