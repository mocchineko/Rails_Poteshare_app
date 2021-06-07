class Room < ApplicationRecord
    validates :name, {presence: true}
    validates :description, {presence: true}
    validates :price, {presence: true}
    validates :address, {presence: true}
    validates :thumbnail, {presence: true}

    def reservations
        return Reservation.where(user_id: self.id)
    end

end
