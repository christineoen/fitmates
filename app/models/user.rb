class User < ActiveRecord::Base
  has_attached_file :photo, :styles => { :medium => "250x250#", :small => "150x150#", :thumb => "30x30#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_file_name :photo, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]
  has_many :taggings
  has_many :tags, through: :taggings
  acts_as_messageable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end

