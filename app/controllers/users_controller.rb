class UsersController < ApplicationController
  before_filter :authenticate_user! , :except => [:index, :nickname]
  before_filter :correct_user?, :except => [:index, :nickname]

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user
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
        #render template: 'users/show'
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



