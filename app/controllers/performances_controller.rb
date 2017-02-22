class PerformancesController < ApplicationController
  include SessionsHelper
  before_action :admin_logged_in
  def edit
    @performance=Performance.find_by_id(params[:id])
  end

  def update
    @performance=Performance.find_by_id(params[:id])
    if @performance.update_attributes(performance_params)
      flash={:info => "更新成功"}
      redirect_to performances_path, flash: flash
    else
      flash={:warning => "更新失败"}
      render 'edit'
    end

  end

  def index
    @performances=Performance.paginate(:page => params[:page], :per_page => 10)
  end

  def performance_params
    params.require(:performance).permit(:arriving_late, :leaving, :training_score, :evaluation)
  end

  def destroy
    @performance = Performance.find_by_id(params[:id])
    @performance.destroy
    redirect_to performances_path(new: false), flash: {success: "信息删除"}
  end


  private



# Confirms a logged-in user.
  def logged_in
    unless logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  def admin_logged_in
    if logged_in? and current_user.role==5
    else
      redirect_to root_url, flash: {:danger => '您没有这个权限'}
    end
  end

end
