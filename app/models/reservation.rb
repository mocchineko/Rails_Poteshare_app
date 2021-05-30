class Reservation < ApplicationRecord
    belongs_to :room

    def reservation_count
        (self.end - self.start).to_i
    end

    def total_amount
        room = Room.find(room_id)
        reservation_count * room.price
    end
end
