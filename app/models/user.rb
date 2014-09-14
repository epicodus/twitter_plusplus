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

  has_attached_file :avatar, :style => { :medium => "300x300", :thumb => "100x100" },
                    :default_url => 'unknown.png'

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :relations, foreign_key: 'follower_id', dependent: :destroy

  has_many :followed_users, through: :relations, source: :followed

  def follow!(another_user)
    relations.create!(followed_id: another_user.id)
  end

  def following?(another_user)
    relations.find_by(followed_id: another_user.id)
  end

  def unfollow!(another_user)
    relations.find_by(followed_id: another_user.id).destroy
  end
private
end
