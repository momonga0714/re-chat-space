require "rails_helper"

describe MessagesController do

  # let(:params) do
  #   { params: { group_id: group.id, message: attributes_for(:message) } }
  # end
  let(:group) {create(:group)}
  let(:user) {create(:user)}
  
  
  describe "GET#index" do
    context "ログインしている場合" do
      before do
        sign_in user
        get :index ,params:{group_id: group.id}
      end

        it "@messageに正しい値が入っていること" do
          expect(assigns(:message)).to be_a_new(Message)
        end
        it "@messagesに正しい値が入っていること" do
          messages = group.messages
          expect(assigns(:messages)).to eq messages
        end
        it "@groupに正しい値が入っていること"do
          expect(assigns(:group)).to eq group
        end
        it "index.html.hamlに遷移すること"do
          expect(response).to render_template :index
        end
    end

    context "ログインしていない場合" do
      it "サインインページに遷移していること" do
        redirect_to new_user_session_path
      end
    end
  end

  describe "POST#create" do
    let(:params) {{ group_id: group.id,user_id: user.id, message: attributes_for(:message) }}
    context "ログインしている状態"do
      before do
        sign_in user
      end

      context "保存に成功した場合" do
        it "メッセージの保存に成功すること"do
          expect{post :create,params: params}.to change(Message, :count).by(1)
        end
        it "メッセージの投稿後意図したページに遷移しているかどうか"do
          post :create,params: params
          expect(response).to redirect_to group_messages_path(group)
        end
      end
      
      context "保存に失敗した場合" do
        let(:invalide_params) {{ group_id: group.id,user_id: user.id, message: attributes_for(:message,content: nil,image: nil) }}
        it "メッセージの保存に失敗すること" do
          expect{post :create,params: invalide_params}.to change(Message, :count).by(0)
        end
        it "保存に失敗した場合、意図したページに遷移していること" do
          post :create,params: invalide_params
          expect(response).to render_template :index
        end
      end
    end

    context "ログインしていない状態" do
      it "意図したページにリダイレクトされていること"do
        post :create, params: params
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end