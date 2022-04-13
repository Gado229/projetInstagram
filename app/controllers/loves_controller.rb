class LovesController < ApplicationController
  def create
    love = current_user.loves.create(blog_id: params[:blog_id])
    redirect_to blogs_path, notice: "#{love.blog.user.name}Le blog de S a été ajouté aux favoris"
  end

  def destroy
    love = current_user.loves.find_by(id: params[:id]).destroy
    redirect_to blogs_path, notice: "#{love.blog.user.name}Blog non blogué de M."
  end
end
