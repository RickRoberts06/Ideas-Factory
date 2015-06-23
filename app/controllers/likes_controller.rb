class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_idea


  def index
    @idea = Idea.find params[:idea_id]
    @users = @idea.liking_users
  end

  def create
    @like = Like.new
    @like.user = current_user
    @like.idea = Idea.find params[:idea_id]
    if @like.save
      redirect_to root_path, notice: "Liked"
    else
      redirect_to root_path, alert: "Can't like"
    end
  end

  def destroy
    @idea = Idea.find params[:idea_id]
    @like = @idea.like_for(current_user)

    if @like.destroy
      redirect_to root_path, notice: "Unliked"
    else
      redirect_to root_path, alert: "Cant Unliked"
    end
  end

  def find_idea
    @idea = Idea.find params[:idea_id]
  end

end
