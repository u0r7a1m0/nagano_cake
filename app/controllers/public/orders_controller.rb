class Public::OrdersController < ApplicationController
  # 注文情報入力画面：１
  def new
    @order = Order.new
  end

  # 注文情報確認画面：２-1
  def confirm
    @cart_items = current_customer.cart_items

    @order = Order.new(order_params)
    @order.postage = 800
    @order.customer_id = current_customer.id
    # １.カレントユーザの登録住所の場合
    if params[:order][:address_number] == "1"
      @order.name = current_customer.full_name
      # @order の各カラムに必要なものを入れます
      # @order.address = current_customer.address_display
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code

    # ２.配送先住所の場合
    elsif params[:order][:address_number] == "2"
      # if Address.exists?(name: params[:order][:address_id])
      @order.name = Address.find(params[:order][:address_id]).name
      @order.address = Address.find(params[:order][:address_id]).address
      @order.postal_code = Address.find(params[:order][:address_id]).postal_code
    elsif params[:order][:address_number] == "3"
      address_new = current_customer.addresses.new(address_params)
      if address_new.save # 確定前(確認画面)で save
      else
        render :new
      end
    else
      redirect_to confirm_path
    end
    # ３.カートアイテムの情報をユーザーに確認してもらうために使用
    @cart_items = current_customer.cart_items.all
    # 配列オブジェクト.inject {|初期値, 要素| ブロック処理 }で配列の合計を表す
    # 初期値は(0)
    @order.total_price = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  # 注文確定処理：2-2
  def create
    cart_items = current_customer.cart_items.all
    # ログインユーザーのカートアイテムをすべて取り出して cart_items に入れます
    @order = current_customer.orders.new(order_params)
    # 渡ってきた値を @order に入れます
    if @order.save
      cart_items.each do |cart|
      # 取り出したカートアイテムの数繰り返します
      # order_detail にも一緒にデータを保存する必要があるのでここで保存
      order_detail = OrderDetail.new
      order_detail.item_id = cart.item_id
      order_detail.order_id = @order.id
      order_detail.amount = cart.amount
      # 購入が完了したらカート情報は削除する→保存
      order_detail.price = cart.item.price
      # カート情報を削除するので item との紐付けが切れる前に保存
      order_detail.save
      end
      redirect_to complete_path
      cart_items.destroy_all
      # ユーザーのカートを空にする
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  # 注文履歴画面：３
  def index
    @orders = current_customer.orders

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
  def address_params
    params.require(:order).permit(:postal_code, :address, :name, :customer_id)
  end

end
