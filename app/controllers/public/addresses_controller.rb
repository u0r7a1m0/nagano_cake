class Public::AddressesController < ApplicationController


  def index
    @address = Address.new
    @addresses = Address.all
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      # 投稿成功した場合
      flash[:notice]="You have created Address successfully."
      redirect_to addresses_path
    else
      @address = Address.new
      render index
    end
  end

  def edit
  end


  def update
  end

  def destroy
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :postal_code, :address, :telephone_number, :is_deleted)
  end

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end

end
