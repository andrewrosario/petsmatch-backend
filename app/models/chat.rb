class Chat < ApplicationRecord
    has_many :messages
    belongs_to :match
    has_one :user_one, through: :match
    has_one :user_two, through: :match

end
