class PetSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :age, :species, :breed, :category, :image

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
    part_one + ':3000' + part_two
  end
end
