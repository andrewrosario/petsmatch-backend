class MatchesController < ApplicationController
  def show
    @matches = Match.all.where('user_one_id = ? or user_two_id = ?', params[:id], params[:id])

    # @matches = User.select('matches.user_two_id').joins(:started_matches).where('user_one_id = ?', 1)

    # render json: matches.as_json(:include => { :user_one => {:only => [:name, :id]} , :user_two => {:only => [:name, :id]}} )
    render json: @matches
  end

  def create
    @match = Match.all.where('(user_one_id = ? AND user_two_id = ?) OR (user_one_id = ? AND user_two_id = ?)', params[:user_one_id], params[:user_two_id], params[:user_two_id], params[:user_one_id])
    @match = Match.create(match_params) if @match.empty?
    puts @match
    render json: @match
  end

  def delete
    @matches = Match.all
    match = Match.all.where('user_one_id = ? or user_two_id = ?', params[:user_one_id], params[:user_one_id])
    chat = Chat.find_by(match_id: match.ids)
    Match.destroy(match.ids)
    render json: @matches
  end

  def match_params
    params.permit(:user_one_id, :user_two_id)
  end
end
