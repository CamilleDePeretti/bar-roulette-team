class AddOpenToBars < ActiveRecord::Migration[5.2]
  def change
    add_column :bars, :open, :string
    add_column :bars, :close, :string
  end
end
