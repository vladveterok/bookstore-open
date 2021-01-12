class AddressesController < ApplicationController
  def create
    redirect_to edit_user_registration_url if Address.create(user: current_user, **address_params)
  end

  def update
    @address = Address.find_by(user: current_user, type: address_params[:type])
    redirect_to edit_user_registration_url if @address.update(address_params)
  end

  private

  def address_params
    params.require(:address).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone, :type)
  end
end
