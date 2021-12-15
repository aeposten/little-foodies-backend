class User < ActiveRecord::Base
    has_secure_password
    has_many :foods
    has_many :children, through: :foods

    validates :username, presence: true, uniqueness: true 
    validates :email, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/, presence: true, u
end
