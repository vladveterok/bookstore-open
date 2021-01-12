Warden::Manager.after_authentication do |user, auth, _opts|
  open_user_cart_id = Cart.open.where(user_id: user.id).last&.id

  if open_user_cart_id
    auth.request.session[:cart_id] = open_user_cart_id
  else
    cart = Cart.find_by(id: auth.request.session[:cart_id])
    user.carts << cart if cart.present?
  end
end
