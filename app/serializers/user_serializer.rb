class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :age, :gender, :bio, :zipcode, :image

  def image
    # return unless object.image.attached?

    # object.image.blob.attributes
    #       .slice('filename', 'byte_size')
    #       .merge(url: image_url)
    #       .tap { |attrs| attrs['name'] = attrs.delete('filename') }
    short_url = Rails.application.routes.url_helpers.rails_blob_path(object.image, only_path: true)
    return short_url
  end

  def image_url
    url_for(object.image)
  end
end
