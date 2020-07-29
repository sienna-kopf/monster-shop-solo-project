class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
  end

  def show
  end

  def update
    order = Order.find(params[:order_id])
    order.update(status: "shipped")
    redirect_to "/admin"
  end
end
