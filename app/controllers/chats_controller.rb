class ChatsController < ApplicationController
    def show
        user = User.find(params[:id])
        matches = Match.joins(:chat, :messages, :user_one, :user_two).where('user_one_id = ? OR user_two_id = ?', user, user)
        
        render json: matches.as_json(include: [{
                                                messages: {
                                                    only: [:text, :user_id]
                                                }}, :user_one, :user_two])
    end

    def index
        chats = Chat.all
        render json: chats.as_json(:include => { :user_one => {:only => [:name, :id]} , :user_two => {:only => [:name, :id]}} )
    end

    def get_chat
        chat = Chat.find(params[:id])
        render json: chat.as_json(include: :messages)
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
