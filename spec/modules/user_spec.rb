require 'rails_helper'

describe User do
  describe "#create" do


    it "必要なデータが入力されれば保存されること" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "nameがない場合登録できないこと" do 
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    it "emailがない場合登録できないこと" do
      user = build(:user,email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "passwordがない場合登録できないこと" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "emailが同じものが登録できないこと" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    it "passwordが登録されていてもpassword_confirmationがないと登録できないこと" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    it "passwordが8文字未満では登録できないこと" do
      user = build(:user, password: "1234567")
      user.valid?
      expect(user.errors[:password]).to include("は8文字以上で入力してください")
    end

    it "passwordが8文字以上で登録できること" do
      user = build(:user, password: "12345678",password_confirmation: "12345678")
      expect(user).to be_valid
    end
  end

  describe "#new" do
    
  end



end