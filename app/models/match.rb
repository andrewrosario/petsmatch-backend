class Match < ApplicationRecord
    has_one :chat
    belongs_to :user_one, class_name: 'User'
    belongs_to :user_two, class_name: 'User',
                          foreign_key: 'user_two_id'
end
