class AddEndDateToLeaves < ActiveRecord::Migration
  def change
    add_column :leaves, :end_date, :date
  end
end
