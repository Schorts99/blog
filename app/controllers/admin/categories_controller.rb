class Admin::CategoriesController < Admin::ApplicationController
  before_action :verify_logged_in

  def new
    @page_title = 'Agregar categoría'
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Categoría agregada'
      redirect_to admin_categories_path
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = 'Categoría actualizada'
      redirect_to admin_categories_path
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      flash[:notice] = 'Categoría removida'
      redirect_to admin_categories_path
    else
      flash[:alert] = 'La categoría no pudo ser removida, intente de nuevo'
      redirect_to admin_categories_path
    end
  end

  def index
    if params[:search]
      @categories = Category.search(params[:search]).all.order('created_at DESC').paginate(per_page: 10, page: params[:page])
    else
      @categories = Category.all.order('created_at DESC').paginate(per_page: 10, page: params[:page])
    end
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end
end
