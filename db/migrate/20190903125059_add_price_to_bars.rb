class AddPriceToBars < ActiveRecord::Migration[5.2]
  def change
    add_column :bars, :price, :integer
  end
end
