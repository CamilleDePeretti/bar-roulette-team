class AddFoursquareIdToBars < ActiveRecord::Migration[5.2]
  def change
    add_column :bars, :foursquare_id, :string
  end
end
