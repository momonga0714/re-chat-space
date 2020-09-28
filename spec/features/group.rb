require "rails_helper"


feature "group" , type: :feature do
  let (:user) { create(:user)}
  let (:group) { create(:group)}
  
  scenario "ログインをし、グループが登録できること"do 
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
  #グループの編集
    visit root_path
    click_on '不動産屋ファンタジー'
    expect(current_path).to eq group_messages_path(group.id-1)
    click_link 'Edit'
    expect(current_path).to eq edit_group_path(group.id-1)
    expect(page).to have_content "チャットグループ編集"
    expect(page).to have_field 'group_name', with: "不動産屋ファンタジー"
    fill_in 'group_name', with: 'TECH CAMP'
    click_button '更新する'
    expect(current_path).to eq root_path
    expect(page).to have_content "TECH CAMP"
    expect(page).to_not have_content "不動産屋ファンタジー"
    expect(page).to have_content "更新完了なり"
  #グループに参加したメンバーの追加・削除
    user_1 = create(:user, name: "鈴木一郎")
    user_2 = create(:user, name: "佐藤二郎")
    user_3 = create(:user, name: "田中三郎")
    visit root_path
    click_on 'TECH CAMP'
    expect(current_path).to eq group_messages_path(group.id-1)
    click_link 'Edit'
    expect(current_path).to eq edit_group_path(group.id-1)
    expect(page).to have_content "チャットグループ編集"
    expect(page).to have_field 'group_name', with: "TECH CAMP"
    check "group_user_ids_#{user_1.id}"
    uncheck "group_user_ids_#{user_2.id}"
    check "group_user_ids_#{user_3.id}"
    click_button '更新する'
    expect(current_path).to eq root_path
    click_on 'TECH CAMP'
    expect(current_path).to eq group_messages_path(group.id-1)
    expect(page).to have_content "鈴木一郎"
    expect(page).to_not have_content "佐藤二郎"
    expect(page).to have_content "田中三郎"
    expect(page).to have_content "#{user.name}"
  #グループを削除する
    expect{
      visit root_path
      click_on "TECH CAMP"
      expect(current_path).to eq group_messages_path(group.id-1)
      click_on "Delete"
      expect(page).to have_content "削除しました"
      expect(page).to_not have_content "TECH CAMP"
    }.to change(Group, :count).by(-1)
  end

  
end