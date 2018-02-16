class CommentsController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :set_comment, only: [:edit, :destroy]

  def create
    @prototype = Prototype.find(params[:prototype_id])
    @comment = @prototype.comments.new(comment_params)
      if @comment.save
        respond_to do |format|
          format.html
          format.json
        end
      else
        @comments = @prototype.comments.includes(:user)
      end
  end

  def edit
  end

  def update
    comment = Comment.find(params[:id])
    if comment.update(update_params)
      redirect_to prototype_path(params[:prototype_id]), notice: 'コメントが更新されました'
    end
  end

  def destroy
    @comment.destroy
    redirect_to prototype_path(params[:prototype_id])
  end

  private
    def comment_params
      params.require(:comment).permit(:content).merge(user_id: current_user.id)
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def update_params
      params.require(:comment).permit(:content)
    end
end
