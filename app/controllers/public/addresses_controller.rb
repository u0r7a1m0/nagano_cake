class Public::AddressesController < ApplicationController

  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      # 投稿成功した場合
      flash[:notice]="登録完了しました！"
      redirect_to addresses_path
    else
      @address = Address.new
      @addresses = Address.all
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end


  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
    # 更新に成功したときの処理
      flash[:notice]="更新完了しました！"
      redirect_to addresses_path
    else
      render 'edit'
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :postal_code, :address, :telephone_number, :is_deleted)
  end

  def address_params
    params.require(:address).permit(:postal_code, :address, :name, :customer_id)
  end

end
