class SalariesController < ApplicationController
  include SessionsHelper
  before_action :admin_logged_in
  def edit
    @salary=Salary.find_by_id(params[:id])
  end

  def update
    @salary=Salary.find_by_id(params[:id])
    if @salary.update_attributes(salary_params)
      flash={:info => "更新成功"}
      redirect_to salaries_path, flash: flash
    else
      flash={:warning => "更新失败"}
      render 'edit'
    end

  end

  def index
    @salaries=Salary.paginate(:page => params[:page], :per_page => 10)
  end

  def salary_params
    params.require(:salary).permit(:basic, :bonus, :insurence, :pulishment)
  end

  def destroy
    @salary = Salary.find_by_id(params[:id])
    @salary.destroy
    redirect_to salaries_path(new: false), flash: {success: "信息删除"}
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
