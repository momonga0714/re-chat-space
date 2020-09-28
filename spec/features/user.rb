require "rails_helper"

feature "user" , type: :feature do
  
  let(:user) {create(:user)}

  scenario "ユーザー登録 → ログイン → 編集 → ログアウト"do
    #ユーザー登録が完了しログイン
      expect{
        visit new_user_registration_path
        fill_in 'user_name', with: "山田太郎"
        fill_in 'user_email', with: "aaa@a.com"
        fill_in 'user_password', with: "yamadatarou"
        fill_in 'user_password_confirmation', with: "yamadatarou"
        find('input[name="commit"]').click
      }.to change(User, :count).by(1)
      expect(current_path).to eq root_path
      expect(page).to have_content("山田太郎")
    #ユーザー登録の編集
      visit root_path
      find('.edit-icon').click
      expect(current_path).to eq edit_user_path(user.id-1)
      expect(page).to have_field 'user_name', with: "山田太郎"
      fill_in 'user_name', with: "山田花子"
      fill_in 'user_email', with: "bbb@b.com"
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      expect(page).to have_content("山田花子")
      expect(page).to_not have_content("山田太郎")
    #ログアウト処理
      visit root_path
      find('.edit-icon').click
      expect(current_path).to eq edit_user_path(user.id-1)
      click_link 'ログアウト'
      expect(current_path).to eq new_user_session_path
  end
end