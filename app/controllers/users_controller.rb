class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  before_action :correct_user, only: [:show]
  def index
    
  end

  def show
    @user=User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page])
    
  end

  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    
    if @user.save
      flash[:success]='ユーザーを登録しました'
      redirect_to @user
    else
      flash.now[:danger]='ユーザー登録に失敗しました'
      render :new
    end
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    
    if @user.update(params[:id])
      flash[:success]='更新しました'
      redirect_to @user
    else
      flash.now[:danger]='更新に失敗しました'
      render :edit
    end
  end
  
  

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def correct_user
    @user = User.find(params[:id])                                           
    unless @user == current_user
     redirect_to @current_user
    end
  end
  
  
end