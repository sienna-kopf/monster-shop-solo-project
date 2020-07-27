class Admin::MerchantsController < Admin::BaseController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(enabled?: false)
    if merchant.save
      flash[:success] = "#{merchant.name} has been disabled"
    else
      flash[:error] = "Merchant could not be disabled"
    end
    redirect_to "/admin/merchants"
  end

  private

  def merchant_params
    params.permit(:enabled?)
  end
end
