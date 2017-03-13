class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    if @comment.save
      flash[:notice] = 'Comentario agregado'
      redirect_to post_path(@post)
    else
      flash[:alert] = "El comentario no pudo ser agregado"
      redirect_to post_path(@post)
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:name, :email, :body, :post_id)
    end
end
