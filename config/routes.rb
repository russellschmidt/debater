Rails.application.routes.draw do

  devise_for :users
  resources :debates do
    resources :positions, except: [:index, :show]
  end
  resources :speeches, except: [:index, :show] do
    resources :contentions
  end


  root 'greetings#hello'

end
