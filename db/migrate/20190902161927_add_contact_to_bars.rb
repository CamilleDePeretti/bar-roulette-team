class AddContactToBars < ActiveRecord::Migration[5.2]
  def change
    add_column :bars, :contact, :text
  end
end
