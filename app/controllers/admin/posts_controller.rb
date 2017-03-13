class Admin::PostsController < Admin::ApplicationController
  before_action :verify_logged_in

  def new
    @page_title = 'Agregar publicación'
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if params[:post][:image].blank?
      @post.image = nil
    end
    if @post.save
      flash[:notice] = 'Publicación agregada'
      redirect_to admin_posts_path
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if params[:post][:image].blank?
      @post.image = nil
    end
    if @post.update(category_params)
      flash[:notice] = 'Publicación actualizada'
      redirect_to admin_posts_path
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = 'Publicación removida'
      redirect_to admin_posts_path
    else
      flash[:alert] = 'La publicación no pudo ser removida, intente de nuevo'
      redirect_to admin_posts_path
    end
  end

  def index
    if params[:search]
      @posts = Post.search(params[:search]).all.order('created_at DESC').paginate(per_page: 10, page: params[:page])
    else
      @posts = Post.all.order('created_at DESC').paginate(per_page: 10, page: params[:page])
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :body, :category_id, :user_id, :tags, :image)
    end
end
