class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :handle
  validates_uniqueness_of :handle
  validates :handle, length: { minimum: 4, maximum: 12 }
  validates :handle, format: { with: /\w+/ }
  validates :bio, length: { maximum: 141 }
  validates_with AttachmentSizeValidator, :attributes => :avatar, :less_than => 1.megabytes

  has_attached_file :avatar,
                    :styles => { :thumb => "64x64#", :medium => "300x300>",
                                  :large => "600x600>" },
                    :default_url => 'unknown.png'

  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/gif", "image/png"]

  has_many :relations, foreign_key: 'follower_id', dependent: :destroy
  has_many :followed_users, through: :relations, source: :followed

  has_many  :reverse_relations, foreign_key: 'followed_id',
            class_name: 'Relation', dependent: :destroy
  has_many :followers, through: :reverse_relations
  has_many :tweets

  def follow!(another_user)
    relations.create!(followed_id: another_user.id)
  end

  def following?(another_user)
    relations.find_by(followed_id: another_user.id)
  end

  def unfollow!(another_user)
    relations.find_by(followed_id: another_user.id).destroy
  end

  def all_tweets
    ((followed_users.map { |user| user.tweets.all}).flatten + tweets)
  end

  def all_tweets_timeline
    all_tweets.sort { |a, b| a.created_at > b.created_at ? -1 : 1 }
  end

  def any_tweets?
    all_tweets.any?
  end

private

end
