class TweetsController < ApplicationController
  before_action :authenticate_user!, :only => [:create, :destroy]
  before_action :build_timeline, :only => [:index, :create]

  def index
      @tweet = Tweet.new
      @user = current_user
      redirect_to new_user_session_path unless user_signed_in?
  end

  def create
    @tweet = Tweet.new(tweet_params)

    if @tweet.save
      @tweet.find_mentions
      respond_to :js
    else
        render('index')
    end
  end

  def search
    @search_term = params[:search_term]
    @tweets = Tweet.basic_search(@search_term)
  end

  def follow
    @user = User.find(params[:id])
    current_user.follow!(@user)

    respond_to :js
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.unfollow!(@user)

    respond_to :js
  end
  

private
  def tweet_params
    params.require(:tweet).permit(:content, :user_id)
  end

  def build_timeline
    return [] unless user_signed_in?
    @tweets = current_user.all_tweets_timeline
  end
end
