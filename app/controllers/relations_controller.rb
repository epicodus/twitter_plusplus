class RelationsController < ApplicationController

  def follow
    user_to_follow = User.find(params[:id])
    current_user.follow!(user_to_follow)
    
    respond_to do |format|
      respond_to js
    end
  end

end
