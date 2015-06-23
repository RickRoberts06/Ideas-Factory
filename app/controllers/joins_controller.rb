class JoinsController < ApplicationController
  before_action :authenticate_user!
  # before_action :find_idea

  def index
    @idea = Idea.find params[:idea_id]
    @users = @idea.joining_users
  end

  def create
    @join = Join.new
    @join.user = current_user
    @join.idea = Idea.find(params[:idea_id])
    if @join.save
      redirect_to root_path, notice: "Joined"
    else
      redirect_to root_path, alert: "Can't Join"
    end
  end

  def destroy
    @idea = Idea.find params[:idea_id]
    @join = @idea.join_for(current_user)
    @join.destroy
      redirect_to root_path, notice: "Un-Joined"
  end


  private

  # def find_idea
  #   @idea = Idea.find params[:idea_id]
  # end
end
