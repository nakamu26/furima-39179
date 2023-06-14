class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :move_to_index, only: [:new, :create]

  before_action :set_item, only: [:new, :create]

  def new
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number)
          .merge(user_id: current_user.id).merge(item_id: params[:item_id]).merge(token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_index
    set_item
    order = Order.find_by(item_id: params[:item_id])
    unless user_signed_in? && current_user.id != @item.user_id && !order
      redirect_to root_path
    end
  end
end
