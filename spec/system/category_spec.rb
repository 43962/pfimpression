# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Reviews", type: :system do
  before do
    @category = FactoryBot.create(:category)
    @admin = FactoryBot.create(:admin) #FactoryBotを利用してcustomerデータを作成
    sign_in @admin
  end

  describe "(admin_categories_path)のテスト" do
    before do
      visit admin_categories_path
    end
    context '表示の確認' do
      it 'admin_categories_pathが"/admin/categories"であるか' do
        expect(current_path).to eq('/admin/categories')
      end
      it '新規登録ボタンが表示されているか' do
        expect(page).to have_button '新規登録'
      end
    end
    context '新規登録処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'category[name]', with: Faker::Lorem.characters(number:10)
        click_button '新規登録'
        expect(page).to have_current_path admin_categories_path
      end
    end
  end

  describe "一覧のテスト" do
    before do
      visit admin_categories_path
    end
    context '表示の確認' do
      it '投稿されたものが表示されているか' do
        expect(page).to have_content @category.name
      end
    end
  end

  describe '編集画面のテスト' do
    before do
      visit edit_admin_category_path(@category)
    end
    context '表示の確認' do
      it '編集前のタイトルと本文がフォームに表示(セット)されている' do
        expect(page).to have_field 'category[name]', with: @category.name
      end
      it '保存ボタンが表示される' do
        expect(page).to have_button '変更を保存'
      end
    end
    context '更新処理に関するテスト' do
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'category[name]', with: Faker::Lorem.characters(number:10)
        click_button '変更を保存'
        expect(page).to have_current_path admin_categories_path
      end
    end
  end
end