class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  validates_presence_of :handle #, :on => [:update, :create]
  validates_uniqueness_of :handle
  validates :handle, length: { minimum: 4, maximum: 12 }
  validates :handle, format: { with: /\w+/ }


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

private


end
