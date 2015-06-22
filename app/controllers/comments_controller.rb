class CommentsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show, :create]
    before_action :find_comment, only: [:destroy, :edit]
    before_action :authorize, only: [:destroy, :edit]

  def index
    @comment = Comment.new
  end

  def create
    @idea = Idea.find params[:idea_id]
    comment_params = params.require(:comment).permit(:body, :user_id)
      # @comment.user_id = current_user.id
        @comment = current_user.comments.new comment_params
       @comment.idea = @idea
       if @comment.save
       redirect_to root_path
       end
     end

  def destroy
    @comment = Comment.find params[:id]
    @comment.destroy
      flash[:notice] = "Comment deleted!"
    redirect_to root_path
  end


  def find_comment
    @comment = Comment.find params[:id]
  end

  def authorize
    unless can? :manage, @comment
      redirect_to root_path, alert: "Access Denied!"
    end
  end

end
