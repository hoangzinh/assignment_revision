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

  def update_history(new_info)
    ret = false
    # diff = Changelog.get_changes(info_to_json, new_info)
    # if diff.e
    history = edited_histories.create(editer_id: id)  
    history.update_changelog(info_to_json,new_info) if history.valid?

  end

  private
    def info_to_json()
      serializable_hash(only: [:firstname,:lastname,:dob])
    end
end
