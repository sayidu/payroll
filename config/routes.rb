Rails.application.routes.draw do
  root "timesheets#new"

  resources :timesheets, only: [:new, :create]

  namespace :api do
    namespace :v1 do
      resources :payroll_reports, only: :create
    end
  end
end
