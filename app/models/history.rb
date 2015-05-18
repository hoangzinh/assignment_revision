class History < ActiveRecord::Base
  validates :editer_id, presence: true
  validates :edited_id, presence: true
  belongs_to :editer, class_name: "User"
  belongs_to :edited, class_name: "User"
  has_many :changelogs, dependent: :destroy
  scope :ordered, -> { order('created_at DESC') }

  def update_changelog(current_info,new_info)
    ret = false
    
    new_info['dob'] = Time.new(new_info["dob(1i)"].to_i, new_info["dob(2i)"].to_i, new_info["dob(3i)"].to_i,0,0,0,"+00:00").utc.to_s   
    diffs = current_info.map{ |k,v| v=v.to_s; [k,v]} - new_info.to_a

    diffs.each do |diff|
      key = diff[0]
      ret = self.changelogs.create(data_name: key,data_from: current_info[key], data_to: new_info[key])
    end

    ret
  end
end
