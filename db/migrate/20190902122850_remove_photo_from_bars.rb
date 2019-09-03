class RemovePhotoFromBars < ActiveRecord::Migration[5.2]
  def change
    remove_column :bars, :photo, :string
  end
end
