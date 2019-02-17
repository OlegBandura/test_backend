class AddFieldCountTimes < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :count_times, :integer
  end
end
