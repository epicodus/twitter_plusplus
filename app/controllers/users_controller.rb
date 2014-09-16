class UsersController < ApplicationController

  def follow
    user_to_follow = User.find(params[:id])
    current_user.follow!(user_to_follow)

    respond_to :js
  end

  def unfollow
    user_to_unfollow = User.find(params[:id])
    current_user.unfollow!(user_to_unfollow)

    respond_to :js
  end
  
end
