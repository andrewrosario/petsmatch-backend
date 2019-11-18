class PetSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :age, :category, :pet_type, :image

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
    puts part_one
    puts part_two
    part_one + part_two
  end
end
