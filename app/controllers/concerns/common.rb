# moduleで宣言
module Common
  # 絶対に必要
  extend ActiveSupport::Concern

  def set_park
    @park = Park.find(params[:id])
  end

end