class ChatsController < ApplicationController
    def show
        chat = Chat.find(params[:id])
        render json: chat.as_json(include: :messages)
    end

    def index
        chats = Chat.all 
        render json: chats.as_json(:include => { :user_one => {:only => [:name, :id]} , :user_two => {:only => [:name, :id]}} )
    end
end
