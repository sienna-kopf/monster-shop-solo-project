class Merchant::DiscountsController < Merchant::BaseController
  def index
    merchant = Merchant.find(current_user.merchant_id)
    @discounts = Discount.where('merchant_id = ?', merchant.id)
  end

  def show
    @discount = Discount.find(params[:discount_id])
  end

  def new
  end

  def create
    merchant = Merchant.find(current_user.merchant_id)

    discount = merchant.discounts.new(discount_params)
    if discount.save
      discount.save
      flash[:success] = "Discount has successfully been created!"
      redirect_to "/merchant/discounts"
    else
      flash[:error] = discount.errors.full_messages.to_sentence
      redirect_to "/merchant/discounts/new"
    end
  end

  def edit
    @discount = Discount.find(params[:discount_id])
  end

  def update
    discount = Discount.find(params[:discount_id])
    discount.update(discount_params)
    if discount.save
      discount.save
      flash[:success] = "Discount has been successfully updated!"
      redirect_to "/merchant/discounts/#{discount.id}"
    else
      flash[:error] = discount.errors.full_messages.to_sentence
      redirect_to "/merchant/discounts/#{discount.id}/edit"
    end
  end

  private

  def discount_params
    params.permit(:percentage_discount, :item_quantity)
  end
end
