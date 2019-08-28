class AddNightToBars < ActiveRecord::Migration[5.2]
  def change
    add_reference :bars, :night, foreign_key: true
  end
end
