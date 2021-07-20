require 'rails_helper'

RSpec.describe 'トップページ', type: :system do
  describe 'トップページ' do
    describe '未ログインの場合' do
      it 'ログインボタンがある' do
        visit root_path
        expect(page).to have_content 'プライバシーポリシー'
        expect(page).to have_content '利用規約'
        expect(page).to have_selector '#line_login'
      end
    end

    describe '各リンクを押した場合' do
      before { visit root_path }
      it 'プライバシーポリシーに遷移できる' do
        click_on 'プライバシーポリシー'
        expect(current_path).to eq privacy_policys_path
      end

      it '利用規約に遷移できる' do
        click_on '利用規約'
        expect(current_path).to eq terms_of_services_path
      end
    end
  end
end