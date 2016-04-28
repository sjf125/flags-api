Rails.application.routes.draw do
  resources :ratings, except: [:new, :edit]
  resources :comments, except: [:new, :edit]
  resources :flags, only: [:index, :show] do
    resources :comments, except: [:new, :edit], shallow: true
  end
  resources :examples, except: [:new, :edit]
  post '/sign-up' => 'users#signup'
  post '/sign-in' => 'users#signin'
  delete '/sign-out/:id' => 'users#signout'
  patch '/change-password/:id' => 'users#changepw'
  resources :users, only: [:index, :show] do
    resources :comments, except: [:new, :edit], shallow: true
  end
end
