require 'rails_helper'

RSpec.describe 'ログイン', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'userコントローラーのテスト' do
    describe 'userが存在するときの画面表示' do
      before 'ユーザーIDをセッションから取り出せるようにする' do
        # session[:user_id]に値を入れユーザーがログインしている状態を作る
        user = create(:user)
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
      end

      it 'ユーザーが作成されたら時間とカテゴリー選択画面に切り替える' do
        visit root_path
        # ログインしているユーザーいれば "#line_login" は表示されないはず
        expect(page).to_not have_selector '#line_login'
      end
    end
  end
end