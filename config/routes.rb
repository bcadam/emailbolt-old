Emailbolt::Application.routes.draw do
  	
  	
  	resources :blogs

	resources :bolts

	root :to => "home#index"

	resources :users, :only => [:index, :show, :edit, :update ]
	get '/auth/:provider/callback' => 'sessions#create'
	get '/signin' => 'sessions#new', :as => :signin
	get '/signout' => 'sessions#destroy', :as => :signout
	get '/auth/failure' => 'sessions#failure'
	
	get '/instant' => 'bolts#instant'
	#get '/home/faq' => "home#faq" 
	
	post '/lookup' => 'home#lookup'
	get '/lookup' => 'home#lookup'

	#get '/home/lookup' => 'home#lookup'
	#post '/home/lookup' => 'home#lookup'

	get '/faq' => "home#faq"
	get '/tos' => 'home#tos'

	#get '/blog' => 'home#blog'

	get '/extension' => "home#extension"
	
	get '/:nickname' => "users#nickname"
	get '/:nickname/edit' => "users#edit"





end
