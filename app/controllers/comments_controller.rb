class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype_id)
    else
      #DRYじゃない気が、、、
      @prototype = Prototype.find(@comment.prototype_id)
      @comments = @prototype.comments.includes(:user)
      #後で質問
      render "prototypes/show"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
