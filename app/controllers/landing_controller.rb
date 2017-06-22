class LandingController < ApplicationController
  def index
    render :layout => "empty"
  end
  params.require(:layout).permit(:username, :email)

end