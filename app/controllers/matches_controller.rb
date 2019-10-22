class MatchesController < ApplicationController
    def show
        matches = Match.all.where('user_one_id = ? or user_two_id = ?', params[:id], params[:id])
        render json: matches.as_json(:include => { :user_one => {:only => [:name, :id]} , :user_two => {:only => [:name, :id]}} )
    end

    def create
        @match = Match.all.where('(user_one_id = ? AND user_two_id = ?) OR (user_one_id = ? AND user_two_id = ?)', params[:user_one_id], params[:user_two_id], params[:user_two_id], params[:user_one_id])
        if @match.length === 0
            @match = Match.create(match_params)
        end
        puts @match
        render json: @match
    end

    def match_params
        params.permit(:user_one_id, :user_two_id)
    end
end
