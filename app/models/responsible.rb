class Responsible < ActiveRecord::Base
  belongs_to :user
  scope :responsible_for, lambda{|id| where(:responsible_id => id)}
end
