class UsersController < ApplicationController


  def edit
    
  end

  def update
    @user = User.find(params[:id])
    @user.update(update_params)
    if @user.save
      redirect_to root_path
    else
      redirect_to edit_user_path
    end
  end

  private

  def update_params
  params.require(:user).permit(:name,:email)
  end
end
