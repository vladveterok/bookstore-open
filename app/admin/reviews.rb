ActiveAdmin.register Review do
  includes :user, :book
  actions :index, :show
  permit_params :title, :body, :date, :score, :book_id, :user_id, :review_status

  scope I18n.t('active_admin.scopes.new'), &:unprocessed
  scope :processed

  action_item :approve, only: :show do
    link_to I18n.t('active_admin.approve'), approve_admin_review_path(resource), method: :put unless resource.approved?
  end

  member_action :approve, method: :put do
    resource.approved!
    redirect_to resource_path, notice: I18n.t('active_admin.approved')
  end

  action_item :reject, only: :show do
    link_to I18n.t('active_admin.reject'), reject_admin_review_path(resource), method: :put unless resource.rejected?
  end

  member_action :reject, method: :put do
    resource.rejected!
    redirect_to resource_path, notice: I18n.t('active_admin.rejected')
  end
end
