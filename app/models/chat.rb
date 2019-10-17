class Chat < ApplicationRecord
    has_many :messages
    belongs_to :match
    has_many :users, through: :matches
