class User < ApplicationRecord
    has_secure_password
    has_many :tasks
    before_save { email.downcase! }
    validates :email, presence: true, uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: { minimum: 6 }
end