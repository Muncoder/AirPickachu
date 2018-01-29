Rails.application.routes.draw do

  resources :todo_lists
	root 'pages#home'

	devise_for :users,
							path: '',
							path_names: {sign_in: 'login', sign_out: 'signout', edit: 'profile', sign_up: 'registration'},
							controllers: { omniauth_callbacks: 'omniauth_callbacks' }

	resources :users, only: [:show]

	resources :rooms, except: [:edit] do
		member do
			get 'listing'
			get 'pricing'
			get 'description'
			get 'photo_upload'
			get 'amenities'
			get 'location'
		end
		resources :photos, only: [:create, :destroy]
		resources :reservations, only: [:create]
	end






	# others
	resources :todo_lists
end
