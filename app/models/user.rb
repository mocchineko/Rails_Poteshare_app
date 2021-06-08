class User < ApplicationRecord
    has_secure_password

    attr_accessor :check_account,
                  :check_profile

    def reservations
        Reservation.where(user_id: self.id)
    end

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, {uniqueness: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }, if: :check_account}
    validates :name, {presence: true}
    validates :icon, {presence: true, if: :check_profile}
    validates :introduce, {presence: true, if: :check_profile}
    validates :password, {presence: true, length: {minimum: 6}, if: :check_account}
end
