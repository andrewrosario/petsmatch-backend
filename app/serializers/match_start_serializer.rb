class MatchStartSerializer < ActiveModel::Serializer
  attributes :id, :chat, :user_two

  def user_two
    ActiveModelSerializers::SerializableResource.new(object.user_two,  serializer: MatchUserStartedSerializer)
  end
end
