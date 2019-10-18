class MessagesController < ApplicationController

    def create
        new_message = Message.create(message_params)
        render json: new_message
    end

    def message_params
        params.require(:message).permit(:text, :user_id, :chat_id)
    end

end
