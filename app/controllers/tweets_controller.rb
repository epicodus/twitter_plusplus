class TweetsController < ApplicationController
  before_action :authenticate_user!, :only => [:create, :destroy]
  has_many :mentions
  
  def index
      @tweet = Tweet.new
      redirect_to new_user_session_path unless user_signed_in?
  end

  def create
    @tweet = Tweet.new(tweet_params)

    if @tweet.save
      @tweet.find_mentions
      @tweet = Tweet.new

      respond_to do |format|
        format.html { redirect_to user_root_path }
        format.js
      end
    else
        render('index')
    end

  end


private
  def tweet_params
    params.require(:tweet).permit(:content, :user_id)
  end

end
