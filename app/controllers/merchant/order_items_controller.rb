class Merchant::OrderItemsController < Merchant::BaseController
  def update
    order = Order.find(params[:order_id])
    item = Item.find(params[:item_id])
    item_order = ItemOrder.find_by(item_id: params[:item_id], order_id: params[:order_id])
    item_order.update(status: "fulfilled")
    item.decrement!("inventory", by = item_order.quantity)
    if item.save
      item.save
      redirect_to "/merchant/orders/#{order.id}"
      flash[:success] = "Item is now fulfilled"
    end
    ## use AR where to check
    if order.item_orders.all? {|item_order| item_order.status == "fulfilled" }
      order.update(status: "packaged")
    end
  end
end
