class UsersController < ApplicationController
  before_filter :authenticate_user! , :except => [:index, :nickname]
  before_filter :correct_user?, :except => [:index, :nickname, :edit]
  before_filter :admin_user?, :only => [:index]
  before_filter :correct_user_nickname?, :only => [:nickname, :edit]

  layout "profilelayout", :only => [ :nickname ]

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


end


