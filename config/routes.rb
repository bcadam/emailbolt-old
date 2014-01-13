Emailbolt::Application.routes.draw do
  	
  	root :to => "home#index"

  	get 'home' => "home#index"

  	resources :blogs

	resources :bolts

	resources :users, :only => [:index, :show, :edit, :update ]
	get '/auth/:provider/callback' => 'sessions#create'
	get '/signin' => 'sessions#new', :as => :signin
	get '/signout' => 'sessions#destroy', :as => :signout
	get '/auth/failure' => 'sessions#failure'
	
	get '/instant' => 'bolts#instant'
	#get '/home/faq' => "home#faq" 
	
	post '/lookup' => 'home#lookup'
	get '/lookup' => 'home#lookup'
	#get '/lookup/:email' => 'home#lookbyemail'

	#get '/home/lookup' => 'home#lookup'
	#post '/home/lookup' => 'home#lookup'

	get '/faq' => "home#faq"
	get '/tos' => 'home#tos'

	#get '/blog' => 'home#blog'
	get '/blog' => 'blogs#blog'
	get '/blog/:title' => 'blogs#title'

	get '/extension' => "home#extension"
	get '/extension.html' => "home#extension"
	
	get '/:nickname/edit' => "users#edit"
	get '/:nickname' => "users#nickname"
	





end
