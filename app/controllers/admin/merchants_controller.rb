class Admin::MerchantsController < Admin::BaseController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if merchant.enabled?
      merchant.toggle(:enabled?)
      merchant.items.update(enabled?: false)
      if merchant.save
        flash[:success] = "#{merchant.name} and all merchant items have been disabled"
      end
    else
      merchant.toggle(:enabled?)
      merchant.items.update(enabled?: true)
      if merchant.save
        flash[:success] = "#{merchant.name} has been enabled"
      end
    end
    redirect_to "/admin/merchants"
  end
end
