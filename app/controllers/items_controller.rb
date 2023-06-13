class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_index, except: [:index, :show, :new, :create]

  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_order, only: [:show, :edit, :update]

  def index
    @items = Item.all.order('created_at DESC')
    @orders = Order.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    params[:item][:image] = @item.image unless params[:item][:image]
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :condition_id,
                                 :shipping_fee_status_id, :prefecture_id,
                                 :scheduled_delivery_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_order
    @order = Order.find_by(item_id: params[:id])
  end

  def move_to_index
    set_item
    set_order
    unless user_signed_in? && current_user.id == @item.user_id && !@order
      redirect_to root_path
    end
  end
end
