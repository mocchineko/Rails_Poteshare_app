class User < ApplicationRecord
    has_secure_password

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, {uniqueness: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }}
    validates :name, {presence: true}
    validates :icon, {presence: true}
    validates :introduce, {presence: true}
    validates :password, {presence: true, length: {minimum: 6}}
end
