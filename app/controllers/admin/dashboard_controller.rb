class Admin::DashboardController < Admin::BaseController
  def index
    orders = Order.all
    @sorted_orders = orders.sort_by {|order| ["packaged","pending","shipped","cancelled"].index(order.status)}

    ## use AR here. 4 different calls for each item and then order those calls.
  end
end
