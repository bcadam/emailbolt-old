class UsersController < ApplicationController
  before_filter :authenticate_user! , :except => [:index, :nickname]
  before_filter :correct_user?, :except => [:index, :nickname, :edit]
  before_filter :admin_user?, :only => [:index]
  before_filter :correct_user_nickname?, :only => [:nickname, :edit]

  def index
      @users = User.all
  end

  def edit
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to "/" + current_user.nickname, :notice => 'Your account has been created! Create some bolts to get started.' 
    else
      render :edit
    end
  end

  def nickname
    render template: 'users/profile'
  end


  def show
      @user = User.find(params[:id])
  end

  

  ##Mailgun methods
  #def get_routes
    ##RestClient.get "https://api:" + ENV["MAIL_GUN_KEY"] + 
    #{}"@api.mailgun.net/v2/routes", :params => {
    #  :skip => 1,
    #  :limit => 1
   # }
 # end

 # def create_route(priority, description, recipient, forward)
 #   data = Multimap.new
  #  data[:priority] = priority
   # data[:description] = description
    #data[:expression] = "match_recipient('" + recipient + "')"
   # data[:action] = "forward('" + forward + "')"
    #data[:action] = "stop()"
    #RestClient.post "https://api:" + ENV["MAIL_GUN_KEY"] + 
    #{}"@api.mailgun.net/v2/routes", data
  #end

  #def get_route_id(routeid)
   # RestClient.
    #get("https://api:" + ENV["MAIL_GUN_KEY"] + 
    #{}"@api.mailgun.net/v2/routes/" + routeid ){|response, request, result| response }
  #end

end


