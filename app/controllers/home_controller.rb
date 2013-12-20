class HomeController < ApplicationController

	helper_method :get_data


  def index
    @users = User.all
  end

  def lookup
  	@lookup = params[:needle]
  end

  def get_data(point)
    RestClient.get "https://personalize.rapleaf.com/v4/dr?first=John&last=Doe&email=#{point}" + "&api_key=e47dc8dcaa6f4a427e96c485ec12ee11&show_available&format=json"
  end

end
