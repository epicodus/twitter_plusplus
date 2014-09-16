class UsersController < ApplicationController

  def follow
    user_to_follow = User.find(params[:id])
    current_user.follow!(user_to_follow)

    respond_to do |format|
      format.js
    end
  end

end
