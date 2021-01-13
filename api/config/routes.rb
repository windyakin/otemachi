Rails.application.routes.draw do
  namespace :v1 do
    resources :workflows, only: %i(show) do
      resources :jobs, only: %i(show create)
    end
  end
end
