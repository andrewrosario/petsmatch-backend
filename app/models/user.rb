class User < ApplicationRecord
    has_many :pets
    has_many :matches
    has_many :chats, through: :matches
    has_many :messages
    has_one :preference
    has_many_attached :images
    has_secure_password
    validates :username, presence: true

    def self.from_token_request(request)
        username = request.params["auth"] && request.params["auth"]["username"]
        self.find_by(username: username)
    end
end
