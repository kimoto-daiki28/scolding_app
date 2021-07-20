require 'rails_helper'

RSpec.describe 'カレンダー', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { create(:user)}
  let!(:wasting1) { create(:wasting, user_id: user.id) }
  let!(:wasting2) { create(:wasting, name: 'お酒', price: 500 , user_id: user.id) }

  describe '無駄遣い管理' do
    describe '未ログインの場合' do
      it 'ユーザーが作成されたら時間とカテゴリー選択画面に切り替える' do
        visit my_page_path
        expect(page).to have_content 'ログインしてください'
      end
    end

    describe 'ログイン済みの場合' do
      before do
        # user = create(:user)
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
      end

      describe '無駄遣い一覧(カレンダー)' do
        it 'カレンダーで一覧が確認できる' do
          visit my_page_path
          expect(page).to have_content '今週の無駄遣い：700円'
          expect(page).to have_content '差分：-700円'
        end
      end
    end
  end
end