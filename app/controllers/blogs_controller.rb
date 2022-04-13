class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

def index
  @blogs = Blog.all.order(id: "desc")
end

def new
  if params[:back]
    @blog = Blog.new(blog_params)
  else
    @blog = Blog.new
  end
end

def create
  @blog = current_user.blogs.build(blog_params)
  if params[:back]
    render :new
  else
    if @blog.save
      ConfirmMailer.confirm_mail(@blog, current_user).deliver
      redirect_to blogs_path, notice: "Vous avez créé un blog !"
    else
      render 'new'
    end
  end
end

def show
  @love = current_user.loves.find_by(blog_id: @blog.id)
end

def edit
  if Blog.find(params[:id]).user.name == current_user.name
      @blog = Blog.find(params[:id])
    else
      redirect_to blogs_path
  end
  unless @blog.user_id == current_user.id
    redirect_to blogs_path, notice: "Non autorisé."
  end
end

def update
  if @blog.update(blog_params)
    redirect_to blogs_path, notice: 'Poste modifié par '
  else
    render 'edit'
  end
end

def destroy
  @blog.destroy
  redirect_to blogs_path, notice: 'Blog supprimé.'
end

def confirm
  @user = User.find(session[:user_id])
  @blog = Blog.new(blog_params)
  @blog.user_id = current_user.id
  render 'new' if @blog.invalid?
end

private

def blog_params
   params.require(:blog).permit(:title, :content, :image, :image_cache)
end

def set_blog
  @blog = Blog.find(params[:id])
end

def logged_in?
  unless current_user.present?
   flash[:notice] = 'Connectez-vous.'
   redirect_to new_session_path
  end
 end
end
