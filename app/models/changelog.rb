class Changelog < ActiveRecord::Base
  validates :data_name, presence: true
  validates :data_from, presence: true
  validates :data_to, presence: true

  belongs_to :history

  def self.get_changes(current_info, new_info)
    diffs = current_info.map{ |k,v| v=v.to_s; [k,v] } - new_info.to_a
  end
end
