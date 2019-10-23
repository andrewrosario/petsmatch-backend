class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :email, :password_digest, :age, :gender, :bio, :zipcode, :image, :pets, :matches, :started_matches, :received_matches
  # :started_matches, :received_matches

  def pets
    ActiveModelSerializers::SerializableResource.new(object.pets,  each_serializer: PetSerializer)
  end

  def started_matches
    ActiveModelSerializers::SerializableResource.new(object.started_matches,  each_serializer: MatchStartSerializer)
  end

  def received_matches
    ActiveModelSerializers::SerializableResource.new(object.received_matches,  each_serializer: MatchReceiveSerializer)
  end

  def image
    return unless object.image.attached?

    object.image.blob.attributes
          .slice('filename', 'byte_size')
          .merge(url: image_url)
          .tap { |attrs| attrs['name'] = attrs.delete('filename') }
  end

  def image_url
    the_url = url_for(object.image)
    part_one = the_url[0..15]
    part_two = the_url[16..-1]
    part_one + ':3000' + part_two
  end

  def matches
    received = ActiveModelSerializers::SerializableResource.new(object.received_matches,  each_serializer: MatchReceiveSerializer)
    sent = ActiveModelSerializers::SerializableResource.new(object.started_matches,  each_serializer: MatchStartSerializer)
    puts received
    puts sent
  end
end
