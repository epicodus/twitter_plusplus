class Tweet < ActiveRecord::Base
  validates_presence_of :content
  validates :content, length: {minimum: 1, maximum: 141 }
  has_many :mentions
  
  def find_mentions
    scan_for_mentions.each { |user| user.mentions << Mention.new(tweet_id: id) }
  end

private

  def scan_for_mentions
    content.scan(/@[\w]{4,12}\b/).map { |m| User.find_by(handle: m[/\w{4,12}/]) }.compact.uniq
  end

end
