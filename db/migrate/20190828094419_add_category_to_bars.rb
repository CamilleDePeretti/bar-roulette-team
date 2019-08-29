class AddCategoryToBars < ActiveRecord::Migration[5.2]
  def change
    add_column :bars, :category, :string
  end
end
