class UsersController < ApplicationController
  def index
  end

  def show
    @user=User.find(params[:id])
  end

  def new
    @user=User.new
  end

  def create
    @user=User.save(user_params)
    
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
end


  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
