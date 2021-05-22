class Room < ApplicationRecord
    validates :name, {presence: true}
    validates :description, {presence: true}
    validates :price, {presence: true}
    validates :address, {presence: true}
    validates :room_name, {presence: true}
end
