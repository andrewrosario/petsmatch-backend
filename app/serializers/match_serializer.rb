class MatchSerializer < ActiveModel::Serializer
  attributes :id, :chat, :user_one, :user_two

  def user_one
    ActiveModel::SerializableResource.new(object.user_one,  serializer: MatchUserStartedSerializer)
  end

  def user_two
    ActiveModel::SerializableResource.new(object.user_two,  serializer: MatchUserStartedSerializer)
  end
end
