class Merchant::ItemsController < Merchant::BaseController

  def index
    @merchant = Merchant.find(current_user.merchant_id)
    @items = @merchant.items
  end

  def update
    item = Item.find(params[:id])
    if item.active?
      item.update(active?: false)
      flash[:success] = "#{item.name} is no longer for sale"
      redirect_to "/merchant/items"
    else
      item.update(active?: true)
      flash[:success] = "#{item.name} is now for sale"
      redirect_to "/merchant/items"
    end
  end

  def delete
    item = Item.find(params[:id])
    item.delete
    flash[:sucess] = "#{item.name} was sucessfully deleted"
    redirect_to "/merchant/items"
  end
end
