class UsersController < ApplicationController
  before_filter :authenticate_user!
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
    
    if @user.id == current_user.id
      render template: 'users/profile'
    else
      render template: 'users/show'
    end

  end


def show
    @user = User.find(params[:id])
  end

end
