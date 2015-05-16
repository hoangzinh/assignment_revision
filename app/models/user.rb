class User < ActiveRecord::Base
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :dob, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :edited_histories, class_name: "History", foreign_key: "edited_id", dependent: :destroy
  has_many :editing_histories, class_name: "History", foreign_key: "editer_id", dependent: :destroy
  has_many :editeds, through: :edited_histories
  has_many :editings, through: :editing_histories
end
