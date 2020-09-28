require 'rails_helper'

describe GroupsController do

  let(:params) do
    { params: {  group: attributes_for(:group) } }
  end

  describe "GET #new" do
    it "new.html.hamlに遷移すること"do
      user = create(:user)
      sign_in user
      get :new
      expect(response).to render_template :new
    end
  end

  describe "GET #index" do
    it "index.html.hamlに遷移すること"do
      user = create(:user)
      sign_in user
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #edit" do
    it "edit.html.hamlに遷移すること"do
      user = create(:user)
      sign_in user
      group = create(:group)
      get :edit ,params: {id: group}
      expect(response).to render_template :edit
    end
  end

  describe "POST #create" do
    it "データベースへデータの保存に成功すること" do
      user = create(:user)
      sign_in user
      expect{post :create,params}.to change(Group, :count).by(1)
    end
    it "データベースへデータの保存に成功後期待通りのページに遷移していること" do
      user = create(:user)
      sign_in user
      post :create,params
      expect(response).to redirect_to root_path
    end

    it "データベースへの保存に失敗したこと"do
      user = create(:user)
      sign_in user
      group = create(:group)
      expect{post :create,params: {group: attributes_for(:group,group_name: nil) }}.to change(Group, :count).by(0)
    end
    it "データベースへの保存に失敗したとき期待通りにページが遷移していること"do
      user = create(:user)
      sign_in user
      post :create,params: {group: attributes_for(:group,group_name: nil) }
      expect(response).to render_template :new
    end

    it "ログアウトしている状態で、保存しようとしたとき期待通りのページに遷移していること"do
      post :create,params: { group: attributes_for(:group, user_id: nil) }
      expect(response).to redirect_to new_user_session_path
    end
  end


  describe "PATCH #update" do
      it "データベースへデータの更新に成功すること" do
        user = create(:user)
        sign_in user
        group = create(:group)
        group_params = {group_name: "new_name"}
        patch :update,params: {id: group, group: group_params}
        expect(group.reload.group_name).to eq "new_name"
      end
      it "データベースへデータの更新後期待通りにページ遷移できていること"do
        user = create(:user)
        sign_in user
        group = create(:group)
        group_params = {group_name: "new_name"}
        patch :update,params: {id: group, group: group_params}
        expect(response).to redirect_to root_path
      end

      it "データの更新に失敗したとき"do
        user = create(:user)
        sign_in user
        group = create(:group)
        group_params = {group_name: nil}
        patch :update,params: {id: group, group: group_params}
        expect(group.reload.group_name).not_to eq nil
      end
      it "データの更新に失敗した時のページ遷移"do
        user = create(:user)
        sign_in user
        group = create(:group)
        group_params = {group_name: nil}
        patch :update,params: {id: group, group: group_params}
        expect(response).to render_template :edit
      end
      it "ログアウトしている状態で、データの更新ができないこと" do
        post :create, params: {group: attributes_for(:group,user_id: nil)}
        expect(response).to redirect_to new_user_session_path
      end
  end

end