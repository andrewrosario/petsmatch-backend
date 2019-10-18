class MatchesController < ApplicationController
    def show
        matches = Match.all.where('user_one_id = ? or user_two_id = ?', params[:id], params[:id])
        render json: matches.as_json(:include => { :user_one => {:only => [:name, :id]} , :user_two => {:only => [:name, :id]}} )
    end
end
