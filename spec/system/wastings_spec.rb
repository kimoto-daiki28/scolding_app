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
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
      end

      describe '無駄遣い一覧(カレンダー)' do
        it 'カレンダーで一覧が確認できる' do
          visit my_page_path
          expect(page).to have_content '今週の無駄遣い：700円'
          expect(page).to have_content '差分：-700円'
        end
      end

      describe '詳細ページ' do
        before { visit wasting_path(wasting1.id) }
        it '詳細と各ボタンが存在する' do
          expect(page).to have_content 'お菓子：200円'
          expect(page).to have_content '戻る'
          expect(page).to have_content '編集'
          expect(page).to have_content '削除'
        end

        it '戻るボタンを押すとmy_pageに遷移する' do
          click_on '戻る'
          expect(current_path).to eq my_page_path
          expect(page).to have_content '今週の無駄遣い：700円'
          expect(page).to have_content '差分：-700円'
        end

        it '編集ボタンを押すと編集ページに遷移する' do
          click_on '編集'
          expect(current_path).to eq edit_wasting_path(wasting1.id)
          expect(page).to have_content 'お菓子を編集する'
        end

        it '削除ボタンを押すと削除できる' do
          click_on '削除'
          expect(page.accept_confirm).to eq '削除しますか？'
          expect(current_path).to eq my_page_path
          expect(page).to have_content '削除しました。'
          expect(page).to have_content '今週の無駄遣い：500円'
        end
      end

      describe '編集ページ' do
        before { visit edit_wasting_path(wasting1.id) }
        context '必要項目を記入した場合' do
          it '編集できる' do
            find("#wasting_name").find("option[value='お酒']").select_option
            fill_in '無駄遣い額', with: '500'
            click_on '更新する'
            expect(current_path).to eq wasting_path(wasting1.id)
            expect(page).to have_content 'お酒：500円'
          end
        end

        context '無駄遣い額が未記入の場合' do
          it '編集できない' do
            find("#wasting_name").find("option[value='お酒']").select_option
            fill_in '無駄遣い額', with: ''
            click_on '更新する'
            expect(page).to have_content '無駄遣い額は数値で入力してください'
          end
        end
      end
    end
  end
end