class BoltsController < ApplicationController
  before_action :set_bolt, only: [:show, :edit, :update, :destroy]
  before_filter :admin_user?, :only => [:index]

  # GET /bolts
  # GET /bolts.json
  def index
    @bolts = Bolt.all
  end

  # GET /bolts/1
  # GET /bolts/1.json
  def show
  end

  # GET /bolts/new
  def new
    @bolt = Bolt.new
  end

  def instant
    
  end

  # GET /bolts/1/edit
  def edit

  end

  # POST /bolts
  # POST /bolts.json
  def create
    @bolt = Bolt.new(bolt_params)

    value = create_route(10, @bolt.description, "#{@bolt.address}@emailbolt" , current_user.email)
    value = JSON.parse(value)
    value = value.fetch("route")
    value = value.fetch("id")
    @bolt.routeid = value


    respond_to do |format|
      if @bolt.save
        format.html { redirect_to "/" + current_user.nickname, :notice => 'That bolt has created!' }
        #format.html { redirect_to @bolt, notice: 'Bolt was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bolt }
      else
        format.html { render action: 'new' }
        format.json { render json: @bolt.errors, status: :unprocessable_entity }
      end
    end

  
  end

  # PATCH/PUT /bolts/1
  # PATCH/PUT /bolts/1.json
  def update
    respond_to do |format|
      if @bolt.update(bolt_params)
        format.html { redirect_to @bolt, alert: 'Bolt was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bolt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bolts/1
  # DELETE /bolts/1.json
  def destroy
    destroy_route(@bolt.routeid.to_s)
    @bolt.destroy
    respond_to do |format|

      format.html { redirect_to "/" + current_user.nickname, :notice => 'That bolt has been deleted!' }
      format.json { head :no_content }
    end
  end
  
  def get_routes
    RestClient.get "https://api:key-1ytwinacpa11k-yg2e8xtjz5dy2myxk4@api.mailgun.net/v2/routes", :params => {
      :limit => 100
    }
  end



## create_route(5,"test", "test@emailbolt.com", "info@rooftop.me")
  def create_route(priority, description, recipient, forward)
    data = Multimap.new
    data[:priority] = priority
    data[:description] = description
    data[:expression] = "match_recipient('#{recipient}')"
    data[:action] = "forward('#{forward}')"
    data[:action] = "stop()"
    RestClient.post "https://api:key-1ytwinacpa11k-yg2e8xtjz5dy2myxk4@api.mailgun.net/v2/routes", data
  end

  def destroy_route(routeid)
    RestClient.
    delete("https://api:key-1ytwinacpa11k-yg2e8xtjz5dy2myxk4@api.mailgun.net/v2/routes/" + routeid ){|response, request, result| response }
  end


  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bolt
      @bolt = Bolt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bolt_params
      params.require(:bolt).permit(:address, :user_id, :description, :routeid)
    end

end
