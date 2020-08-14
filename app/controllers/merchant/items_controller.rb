class Merchant::ItemsController < Merchant::BaseController

  def index
    @merchant = Merchant.find(current_user.merchant_id)
    @items = @merchant.items

    # only send one thing to view
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

  def destroy
    ## add conditional logic here to make sure it cant be deleted
    item = Item.find(params[:id])
    item.delete
    flash[:sucess] = "#{item.name} was sucessfully deleted"
    redirect_to "/merchant/items"
  end

  def new
  end

  def create
    merchant = Merchant.find(current_user.merchant_id)
    item = merchant.items.create(item_params)
    if item.save
      flash[:success] = "New item has been sucessfully added"
      redirect_to "/merchant/items"
    else
      flash[:error] = item.errors.full_messages.to_sentence
      redirect_to "/merchant/items/new"
    end
  end

  private

  def item_params
    params.permit(:name, :description, :image, :price, :inventory)
  end
end
