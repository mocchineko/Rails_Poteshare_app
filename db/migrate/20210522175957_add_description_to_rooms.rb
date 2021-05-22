class AddDescriptionToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :description, :string
    add_column :rooms, :thumbnail, :string
  end
end
