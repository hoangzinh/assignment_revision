class History < ActiveRecord::Base
  belongs_to :editer, class_name: "User"
  belongs_to :edited, class_name: "User"
  has_many :changelogs, dependent: :destroy
  scope :ordered, -> { order('created_at DESC') }
end
