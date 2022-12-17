class Public::OrdersController < ApplicationController
  # 注文情報入力画面：１
  def new
    @order = Order.new
  end

  # 注文情報確認画面：２-1
  def confirm

    @cart_items = current_customer.cart_items

    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    # １.カレントユーザの登録住所の場合
    if params[:order][:address_number] == "1"
    @order.name = current_customer.full_name
    # @order の各カラムに必要なものを入れます
    @order.address = current_customer.address_display

    # ２.配送先住所の場合
    elsif params[:order][:address_number] == "2"
    if Address.exists?(name: params[:order][:registered])
    @order.name = Address.find(params[:order][:registered]).name
    @order.address = Address.find(params[:order][:registered]).address
    else
      render :new
    end
    elsif params[:order][:address_number] == "3"
      address_new = current_customer.addresses.new(address_params)
    if address_new.save # 確定前(確認画面)で save
    else
      render :new
    end
    else
      redirect_to confirm_path
    end
    # ３.カートアイテムの情報をユーザーに確認してもらうために使用します
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  # 注文確定処理：2-2
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


  # 注文履歴画面：３
  def index

  end



  # 注文履歴詳細ページ：４
  def show

  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :postal_code, :address, :telephone_number, :is_deleted)
  end
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :postage, :total_price, :order_status, :payment)
  end
  def order_detail_params
    params.require(:order_detail).permit(:price, :amount, :production_status)
  end
  def cart_item_params
    params.require(:cart_item).permit(:price, :amount, :production_status, :item_id, :customer_id)
  end
  def item_params
    params.require(:item).permit(:name, :item_image, :introduction, :price, :is_active, :genre_id)
  end

end
