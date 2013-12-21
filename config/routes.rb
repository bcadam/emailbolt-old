Emailbolt::Application.routes.draw do
	resources :bolts

	root :to => "home#index"

	resources :users, :only => [:index, :show, :edit, :update ]
	get '/auth/:provider/callback' => 'sessions#create'
	get '/signin' => 'sessions#new', :as => :signin
	get '/signout' => 'sessions#destroy', :as => :signout
	get '/auth/failure' => 'sessions#failure'

	get '/home/faq' => "home#faq"
	post '/home/lookup' => 'home#lookup'
	get '/faq' => "home#faq"

	get '/:nickname' => "users#nickname"



  

end
