class Merchant::DashboardController < Merchant::BaseController
  def index
    @merchant = Merchant.find(current_user.merchant_id)
    @merchant_orders = Order.joins(:items).where("items.merchant_id = ? and orders.status = 'pending'", @merchant.id)

    ## pull into model method and call from view
  end
end
