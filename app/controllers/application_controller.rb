class ApplicationController < ActionController::Base

  # before_action :configure_permitted_parameters, if: :devise_controller?
  # def top
  #   @customer = Customer.find(customer_params)
  # end
  # private
  # def customer_params
  #   params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :postal_code, :address, :telephone_number, :is_deleted)
  # end
  def search
    #Viewのformで取得したパラメータをモデルに渡す
    @items = Item.search(params[:search])
  end

end
