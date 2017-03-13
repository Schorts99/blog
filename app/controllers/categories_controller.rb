class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @categories = Category.all.order('created_at DESC')
    @posts = @category.posts.order('created_at DESC').paginate(per_page: 10, page: params[:page])
  end
end
