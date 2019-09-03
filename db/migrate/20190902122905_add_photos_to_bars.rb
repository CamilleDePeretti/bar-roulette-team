class AddPhotosToBars < ActiveRecord::Migration[5.2]
  def change
    add_column :bars, :photos, :string, array: true
  end
end
