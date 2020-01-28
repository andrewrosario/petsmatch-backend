class User < ApplicationRecord
  has_many :pets

  has_many :started_matches, class_name: 'Match', foreign_key: :user_one_id
  has_many :received_matches, class_name: 'Match' , foreign_key: :user_two_id

  has_many :messages
  has_one :preference
  has_one_attached :image
  #has_secure_password
  #validates :email, presence: true

  def index
    @users =
    render json: User.all.with_attached_images
  end

  def image_url
    this_url = url_for(image)
    this_url
  end

  def pets_i_want
    pet_types = []
    %w[dog cat fish reptile bird exotic rodent].each do |type|
      pet_types.push(type) if preference["wants_#{type}"]
    end
    pet_types
  end
end
