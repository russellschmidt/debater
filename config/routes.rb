Rails.application.routes.draw do

  devise_for :users
  resources :debates do
    resources :positions, except: [:index, :show]
  end
  resources :speeches, except: [:index, :show] do
    resources :contentions, except: [:index, :show]
  end

  resources :contentions, only: [] do
    resources :refutations, except: [:index, :show]
  end

  resources :arguments, except: [:index, :show]

  root 'greetings#hello'

end
