class AddPageToNights < ActiveRecord::Migration[5.2]
  def change
    add_column :nights, :page, :integer, default: 1
  end
end
