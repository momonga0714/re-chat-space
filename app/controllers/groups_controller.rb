class GroupsController < ApplicationController


  def index
  end

  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    @group = Group.create(group_set)
    if current_user
      if @group.save
        redirect_to root_path , notice: "メンバーの登録が完了いたしました"
      else
        render :new, notice: "登録できませんでした"
      end
    else
      redirect_to new_user_session_path
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
      @group = Group.find(params[:id])
      @group.update(group_set)
    if @group.save
      redirect_to root_path,notice: "更新完了なり"
    else
      render :edit
    end
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    
    redirect_to root_path,notice: "削除しました"
    
  end

  private
  def group_set
  params.require(:group).permit(:group_name,user_ids: [])
  end
  
end
