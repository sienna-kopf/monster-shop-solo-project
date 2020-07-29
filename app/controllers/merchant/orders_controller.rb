class Merchant::OrdersController < Merchant::BaseController

  def show
    @order = Order.find(params[:order_id])
  end

  def update
    item = Item.find(params[:item_id])
    order_item = ItemOrder.where('item_orders.item_id = ?', params[:item_id]).first
    order_item.update(status: "fulfilled")
    item.decrement!("inventory", by = order_item.quantity)
    if item.save
      redirect_back(fallback_location: root_path)
      flash[:success] = "Item is now fulfilled"
    end
  end
end
