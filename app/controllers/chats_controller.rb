class ChatsController < ApplicationController
    def show
        chat = Chat.find(params[:id])
        render json: chat.as_json(include: :messages)
    end

    def index
        chats = Chat.all 
        render json: chats.as_json(:include => { :user_one => {:only => [:name, :id]} , :user_two => {:only => [:name, :id]}} )
    end

    def create
        puts 'create new chat controller'
        @chat = Chat.find_or_create_by(match_id: params[:match_id])
        puts @chat
        render :json => @chat.to_json
    end

    def chat_params
        params.require(:chat).permit(:match_id)
    end
end
