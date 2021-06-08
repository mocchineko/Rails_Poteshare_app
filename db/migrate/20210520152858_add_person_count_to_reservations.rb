class AddPersonCountToReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :person_count, :integer
  end
end
