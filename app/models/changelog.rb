class Changelog < ActiveRecord::Base
  validates :data_name, presence: true
  validates :data_from, presence: true
  validates :data_to, presence: true

  belongs_to :history
end
