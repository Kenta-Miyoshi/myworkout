class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
 
  
  def new
    @post = current_user.posts.build 
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '投稿しました'
      redirect_to @current_user
    else
      @posts = current_user.posts.order(id: :desc).page(params[:page])
      flash.now[:danger] = '失敗しました'
      render new_post_path
    end
  end

  def destroy
    @post.destroy
    flash[:success] = '削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :content, :img)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to @current_user
    end
  end
  
end
