class HomeController < ApplicationController
	helper_method :get_data

  layout "extensionlayout", :only => [ :extension ]

  def index
    @users = User.all
  end

  def lookup
  	@lookup = params[:needle]
  end

  #def lookbyemail
  #  @lookup = params[:email]
  #  render template: 'home/lookup'
  #end

  def get_data(point)
    RestClient.get "https://personalize.rapleaf.com/v4/dr?&email=#{point}" + "&api_key=e47dc8dcaa6f4a427e96c485ec12ee11&show_available&format=json"
  end

  def faq

  end

  def tos
    
  end

  def extension
    if current_user
      @user = current_user
    end

    response.headers.except! 'X-Frame-Options'
  end


end
