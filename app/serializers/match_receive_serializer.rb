class MatchReceiveSerializer < ActiveModel::Serializer
  attributes :id, :chat, :user_one

  def user_one
    ActiveModelSerializers::SerializableResource.new(object.user_one,  serializer: MatchUserStartedSerializer)
  end
end
