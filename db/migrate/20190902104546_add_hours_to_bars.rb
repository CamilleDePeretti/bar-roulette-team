class AddHoursToBars < ActiveRecord::Migration[5.2]
  def change
    add_column :bars, :hours, :text
  end
end
