class Merchant::DashboardController < Merchant::BaseController
  def index
    @merchant = Merchant.find(current_user.merchant_id)
    binding.pry
    # my_pending_orders = Item.where("merchant_id = ?", @merchant.id)
    # id_i_need = 
    
    # Order.joins(:items).distinct.where(items: {merchant_id: @merchant.id}).where(orders: {status: "pending"})

    # Item.where("merchant_id = ?", @merchant.id).joins(:orders).where("status = ?", "pending")
    
    # Item.where("merchant_id = ?", @merchant.id).select(:orders).where("status = ?", "pending")
    
    # Order.where("status = ?", "pending").select(:items).where("merchant_id = ?", @merchant.id)
    
  end
end
