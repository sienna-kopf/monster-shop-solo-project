class Merchant::DashboardController < Merchant::BaseController
  def index
    @merchant = Merchant.find(current_user.merchant_id)

    @merchant_orders = Order.joins(:items).where("items.merchant_id = ? and orders.status = 'pending'", @merchant.id)

    # @total_quantity = @merchant_orders.item_orders.where('item_orders.merchant_id = ?', @merchant.id).sum(:quantity)
  end
end
