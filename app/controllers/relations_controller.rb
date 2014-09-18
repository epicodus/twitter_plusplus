class RelationsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @followers = @user.followers
    @following = @user.followed_users
  end


end
