class Tweet < ActiveRecord::Base
  validates_presence_of :content
  validates :content, length: {minimum: 1, maximum: 141 }

private
  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
