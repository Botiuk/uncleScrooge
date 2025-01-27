# frozen_string_literal: true

require 'rails_helper'

# RSpec.describe 'Categories' do
#   describe 'non registered user management' do
#     it 'cannot GET index' do
#       get categories_path
#       expect(response).to redirect_to(new_user_session_path)
#       expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
#     end

#     it 'cannot GET new and redirects to the sign_in page' do
#       get new_category_path
#       expect(response).to redirect_to(new_user_session_path)
#       expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
#     end

#     it 'cannot GET edit and redirects to the sign_in page' do
#       category = create(:category)
#       get edit_category_path(category)
#       expect(response).to redirect_to(new_user_session_path)
#       expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
#     end

#     it 'cannot GET show' do
#       category = create(:category)
#       get category_path(category)
#       expect(response).to redirect_to(new_user_session_path)
#       expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
#     end

#     it 'can GET shop' do
#       category = create(:category)
#       get shop_path(id: category.id)
#       expect(response).to be_successful
#     end
#   end

#   describe 'registered user management' do
#     let(:test_user) { create(:user) }

#     before do
#       login_as(test_user, scope: :user)
#     end

#     it 'cannot GET index' do
#       get categories_path
#       expect(response).to redirect_to(root_path)
#       expect(flash[:alert]).to include I18n.t('alert.cancan_access_denied')
#     end

#     it 'cannot GET new and redirects to root page' do
#       get new_category_path
#       expect(response).to redirect_to(root_path)
#       expect(flash[:alert]).to include I18n.t('alert.cancan_access_denied')
#     end

#     it 'cannot GET edit and redirects to root page' do
#       category = create(:category)
#       get edit_category_path(category)
#       expect(response).to redirect_to(root_path)
#       expect(flash[:alert]).to include I18n.t('alert.cancan_access_denied')
#     end

#     it 'cannot GET show' do
#       category = create(:category)
#       get category_path(category)
#       expect(response).to redirect_to(root_path)
#       expect(flash[:alert]).to include I18n.t('alert.cancan_access_denied')
#     end

#     it 'can GET shop' do
#       category = create(:category)
#       get shop_path(id: category.id)
#       expect(response).to be_successful
#     end
#   end

#   describe 'user-admin management' do
#     let(:test_user) { create(:user, role: 'admin') }

#     before do
#       login_as(test_user, scope: :user)
#     end

#     it 'can GET index' do
#       get categories_path
#       expect(response).to be_successful
#     end

#     it 'can GET new' do
#       get new_category_path
#       expect(response).to be_successful
#     end

#     it 'can POST create' do
#       post categories_path, params: { category: attributes_for(:category) }
#       expect(response).to be_redirect
#       follow_redirect!
#       expect(flash[:notice]).to include(I18n.t('notice.create.category'))
#     end

#     it 'can GET edit' do
#       category = create(:category)
#       get edit_category_path(category)
#       expect(response).to be_successful
#     end

#     it 'can PUT update' do
#       category = create(:category, name: 'Coins')
#       put category_path(category), params: { category: { name: 'Banknotes' } }
#       expect(category.reload.name).to eq('Banknotes')
#       expect(response).to redirect_to(category_url(category))
#       expect(flash[:notice]).to include(I18n.t('notice.update.category'))
#     end

#     it 'can DELETE destroy, category has not childrens' do
#       category = create(:category)
#       delete category_path(category)
#       expect(response).to redirect_to(categories_url)
#       expect(flash[:notice]).to include(I18n.t('notice.destroy.category'))
#     end

#     it 'cannot DELETE destroy category with childrens' do
#       category_root = create(:category)
#       create(:category, parent_id: category_root.id)
#       delete category_path(category_root)
#       expect(response).to redirect_to(category_url(category_root))
#       expect(flash[:alert]).to include I18n.t('alert.destroy.category')
#     end

#     it 'can GET shop' do
#       category = create(:category)
#       get shop_path(id: category.id)
#       expect(response).to be_successful
#     end
#   end
# end
