class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  validates_presence_of :handle #, :on => [:update, :create]
  validates_uniqueness_of :handle
  validates :handle, length: { minimum: 4, maximum: 12 }
  validates :handle, format: { with: /\w+/ }
  validates :bio, length: { maximum: 141 }


  has_attached_file :avatar, :style => { :medium => "300x300", :thumb => "100x100" },
                    :default_url => 'unknown.png'

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

private
end
