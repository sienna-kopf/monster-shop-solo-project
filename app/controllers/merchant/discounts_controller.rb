class Merchant::DiscountsController < Merchant::BaseController
  def index
    merchant = Merchant.find(current_user.merchant_id)
    @discounts = Discount.where('merchant_id = ?', merchant.id)
  end

  def show
    @discount = Discount.find(params[:discount_id])
  end
end
