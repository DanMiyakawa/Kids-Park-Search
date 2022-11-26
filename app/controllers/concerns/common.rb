# moduleで宣言
module Common
  # 絶対に必要
  extend ActiveSupport::Concern

  def set_park
    @park = Park.find(params[:id])
  end
  
  def set_customer
    @customer = Customer.find(params[:id])
  end

end