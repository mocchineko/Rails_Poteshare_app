class DescripitionToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :descripition, :string
    add_column :rooms, :price, :integer
    add_column :rooms, :address, :string
  end
end
