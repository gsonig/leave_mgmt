class RemoveDateFromLeaves < ActiveRecord::Migration
  def change
    remove_column :leaves, :date, :date
  end
end
