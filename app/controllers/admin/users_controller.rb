class Admin::UsersController < Admin::ApplicationController
  before_action :verify_logged_in

  def new
    @page_title = 'Agregar usuario'
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'usuario agregado'
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'usuario actualizado'
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = 'Usuario removido'
      redirect_to admin_users_path
    else
      flash[:alert] = 'El usuario no pudo ser removido, intente de nuevo'
      redirect_to admin_users_path
    end
  end

  def index
    if params[:search]
      @users = User.search(params[:search]).all.order('created_at DESC').paginate(per_page: 10, page: params[:page])
    else
      @users = User.all.order('created_at DESC').paginate(per_page: 10, page: params[:page])
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
