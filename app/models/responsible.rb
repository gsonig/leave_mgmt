class Responsible < ActiveRecord::Base
  belongs_to :user
  scope :responsible_for, lambda{|id| where(:responsible_id => id)}

  def return_responsible_user
  	User.where(id: self.responsible_id).first
  end
end
