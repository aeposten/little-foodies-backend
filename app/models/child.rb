class Child < ActiveRecord::Base
    has_many :foods
    has_one :parent, through: :foods
end
