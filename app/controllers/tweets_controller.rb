class TweetsController < ApplicationController
  # respond_to :html, :js
  before_action :authenticate_user!, :only => [:create, :destroy]
  before_action :prepare_tweet_vars, only: [:new, :index]

  def index
      redirect_to new_user_session_path unless user_signed_in?
  end

  def new
    respond_to :js
  end

  def create
    @tweet = Tweet.new(tweet_params)

    if @tweet.save
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

  def prepare_tweet_vars
    @tweet = Tweet.new
    if user_signed_in?
      @tweets = current_user.tweets.all
    else
      @tweets = nil
    end
  end

end
