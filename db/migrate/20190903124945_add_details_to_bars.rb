class AddDetailsToBars < ActiveRecord::Migration[5.2]
  def change
    add_column :bars, :details, :text
  end
end
