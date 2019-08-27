class CreateBars < ActiveRecord::Migration[5.2]
  def change
    create_table :bars do |t|
      t.string :name
      t.string :address
      t.float :lat
      t.float :lng
      t.string :postcode
      t.string :city
      t.string :state
      t.string :country

      t.timestamps
    end
  end
end
