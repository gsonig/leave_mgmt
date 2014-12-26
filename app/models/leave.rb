class Leave < ActiveRecord::Base
  belongs_to :user
  validates :subject, presence:true,length: { minimum: 5}
  validates_presence_of :start_date, :end_date
  scope :this_months_leave, lambda { |date| where("start_date >= ? AND start_date <= ?", 
  date.beginning_of_month, date.end_of_month) }
end
