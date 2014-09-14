class TweetsController < ApplicationController
  before_action :authenticate_user!, :only => [:create, :destroy]




end
