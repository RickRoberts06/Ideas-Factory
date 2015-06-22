class IdeasController < ApplicationController
  before_action :find_idea, only: [:edit, :update, :destroy, :show]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize, only: [:destroy, :edit]


  def index
    @ideas = Idea.all
    @comment = Comment.new
    # @idea = Idea.find params[:id]
    # @join = @idea.join_for(current_user)
  end

  def new
    @idea = Idea.new
  end

  def create
      @idea = Idea.new(params.require(:idea).permit([:title, :body, :user_id, {joining_user_ids: []}]))
      @idea.user = current_user
      if @idea.save
       flash[:notice] = "Your post have been saved!"
       redirect_to root_path
     end
  end

  def show
    @comment = Comment.new

    @idea = Idea.find params[:id]
    @join = @idea.join_for(current_user)
  end

  def find_idea
    @idea = Idea.find params[:id]
  end

  def authorize
    unless can? :manage, @idea
      redirect_to root_path, alert: "Access Denied"
    end
  end

end
