class Merchant::ItemsController < Merchant::BaseController

  def index
    @merchant = Merchant.find(current_user.merchant_id)
    @items = @merchant.items
  end

  def update
    item = Item.find(params[:id])
    item.toggle(:active?)
    if item.save
      flash[:success] = "#{item.name} is no longer for sale"
      redirect_to "/merchant/items"
    end
  end
end
