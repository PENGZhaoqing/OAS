class MaterialsController < ApplicationController
  include SessionsHelper
  before_action :logged_in, except: :destroy
  before_action :admin_logged_in, only: :destroy
  before_action :check_params, only: :create
  respond_to :js, :html

  def index
    @materials=Material.search(params).order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
  end

  def create
    @material = Material.new(file_params)
    @material.user=current_user
    if @material.save
      flash="文件:#{@material.file_file_name} 已经成功上传"
      redirect_to materials_path, flash: {success: flash} and return
    else
      flash="文件:#{@material.file_file_name} 上传失败,请重试"
      render 'index', flash: {danger: flash}
    end
  end

  def destroy
    @material=Material.find_by_id(params[:id])
    flash="文件: #{@material.file_file_name} 已被成功删除"
    @material.destroy
    redirect_to materials_path, flash: {success: flash}
  end

  private
  def file_params
    params.require(:material).permit(:file)
  end

  # Confirms a logged-in user.
  def logged_in
    unless logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  def check_params
    if params[:material].nil?
      flash="请选择要上传的文件"
      redirect_to materials_path, flash: {warning: flash}
    elsif !["application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/octet-stream"]
               .include?(params[:material][:file].content_type)
      flash="请上传excel格式的文件(xlsx/xlsm)"
      redirect_to materials_path, flash: {danger: flash}
    end
  end


  def admin_logged_in
    if logged_in? and current_user.role==5
    else
      redirect_to root_url, flash: {:danger => '您没有这个权限'}
    end
  end
end
