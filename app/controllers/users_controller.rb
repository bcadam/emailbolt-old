class UsersController < ApplicationController
  before_filter :authenticate_user! , :except => [:index, :nickname]
  before_filter :correct_user?, :except => [:index, :nickname]
  #before_filter :admin_user?, :only => [:index]

  def index
    if current_user.has_role? :admin
      @users = User.all
    else
      redirect_to root_url, :alert => 'You aren\'t an admin.'
    end
  end

  def edit
    @user = User.find(params[:id])
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
      @user = User.find_by nickname: params[:nickname]
      if @user == nil
          count = User.where('LOWER(nickname) = ?', params[:nickname].downcase) unless params[:nickname].blank?
          @user = count.take
      end
      

      if current_user && @user.id == current_user.id
        render template: 'users/profile'
      else
        redirect_to root_url, :alert => 'That\'s not your page.'
      end


  end


  def show
      @user = User.find(params[:id])
      end

  end

  ##Mailgun methods
  def get_routes
    RestClient.get "https://api:" + ENV["MAIL_GUN_KEY"] + 
    "@api.mailgun.net/v2/routes", :params => {
      :skip => 1,
      :limit => 1
    }
  end

  def create_route(priority, description, recipient, forward)
    data = Multimap.new
    data[:priority] = priority
    data[:description] = description
    data[:expression] = "match_recipient('" + recipient + "')"
    data[:action] = "forward('" + forward + "')"
    data[:action] = "stop()"
    RestClient.post "https://api:" + ENV["MAIL_GUN_KEY"] + 
    "@api.mailgun.net/v2/routes", data
  end

  def get_route_id(routeid)
    RestClient.
    get("https://api:" + ENV["MAIL_GUN_KEY"] + 
    "@api.mailgun.net/v2/routes/" + routeid ){|response, request, result| response }
  end

  

  #def boltdestroy
    #@bolt = Bolt.find(params[:id])
    #@bolt.destroy
    #respond_to do |format|
     # format.html { redirect_to bolts_url }
     # format.json { head :no_content }
   # end
 # end


