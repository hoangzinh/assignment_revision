class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :edited_histories, class_name: "History", foreign_key: "edited_id", dependent: :destroy
  has_many :editing_histories, class_name: "History", foreign_key: "editing_id", dependent: :destroy
  has_many :editeds, through: :edited_histories
  has_many :editings, through: :editing_histories
end
