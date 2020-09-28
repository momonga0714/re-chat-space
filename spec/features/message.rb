require "rails_helper"

feature "message" , type: :feature do
  let (:user) { create(:user)}
  let (:message) { create(:message)}
  let (:group) { create(:group)}

  scenario "ログインしてメッセージの投稿ができること"do
    #ログイン処理
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    find('input[name="commit"]').click
    expect(current_path).to eq  root_path
    expect(page).to have_content("#{user.name}")
    #グループの作成
    expect{
      find('.new-icon').click
      expect(current_path).to eq new_group_path
      fill_in 'group_name', with: '不動産屋ファンタジー'
      find('input[name="commit"]').click
    }.to change(Group, :count).by(1)
    #メッセージのみ投稿
    expect{
      visit root_path
      click_on '不動産屋ファンタジー'
      expect(current_path).to eq group_messages_path(group.id-1)
      fill_in 'message_content',with: "こんにちは"
      find('input[name="commit"]').click
    }.to change(Message, :count).by(1)
    #画像のみ投稿
    expect{
      visit root_path
      click_on '不動産屋ファンタジー'
      expect(current_path).to eq group_messages_path(group.id-1)
      attach_file 'image-content', "#{Rails.root}/spec/fixtures/mv2_sp.jpg"
      find('input[name="commit"]').click
    }.to change(Message, :count).by(1)
    #メッセージと画像の投稿
    expect{
      visit root_path
      click_on '不動産屋ファンタジー'
      expect(current_path).to eq group_messages_path(group.id-1)
      attach_file 'image-content', "#{Rails.root}/spec/fixtures/mv2_sp.jpg"
      fill_in 'message_content',with: "この画像見てー"
      find('input[name="commit"]').click
    }.to change(Message, :count).by(1)
  end

  
end