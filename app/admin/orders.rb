ActiveAdmin.register Cart, as: 'Order' do
  includes :user, :line_items
  actions :index
  decorate_with CartDecorator

  scope :in_progress, default: true
  scope :delivered
  scope :canceled

  index do
    selectable_column

    column :number do |order|
      order.order_number || I18n.t('admin.on_user_state')
    end
    column :order_date
    column :state do |order|
      order.aasm.human_state
    end
  end

  batch_action :deliver, if: proc { @current_scope.scope_method == :in_progress } do |ids|
    orders = Cart.in_progress.where(id: ids)
    orders.each(&:deliver!) if orders.any?
    redirect_to(admin_orders_path)
  end

  batch_action :complete_delivery, if: proc { @current_scope.scope_method == :in_progress } do |ids|
    orders = Cart.delivery.where(id: ids)
    orders.each(&:complete_delivery!) if orders.any?
    redirect_to(admin_orders_path)
  end

  batch_action :cancel, if: proc { @current_scope.scope_method == :in_progress } do |ids|
    orders = Cart.where(id: ids)
    orders.each(&:cancel!) if orders.any?
    redirect_to(admin_orders_path)
  end
end
