class DepartmentsController < ApplicationController
  include SessionsHelper
  include DepartmentsHelper
  before_action :logged_in

  def index
    @departments=Department.search(params).paginate(:page => params[:page], :per_page => 10)
  end

  def edit
    @department= Department.find_by_id(params[:id])
    #@department[:content]=@department.article.content.gsub('<br/>',"\r").gsub('&nbsp;',' ')
  end

  def show
    @department= Department.find_by_id(params[:id])
  end

  def update
    @department= Department.find_by_id(params[:id])
    @department.article.update_attribute(:content,params[:article])
    if @department.update_attributes(department_params)
      flash={:info => "更新成功"}
    else
      flash={:warning => "更新失败"}
    end
    redirect_to departments_path, flash: flash
  end

  def destroy
    @department = Department.find_by_id(params[:id])
    @department.users.each do |user|
      user.update_attribute(:department_id,Department.first.id)
    end
    @department.destroy
    redirect_to departments_path(new: false), flash: {success: "部门已删除"}
  end

  def new
    @department=Department.new
  end

  def create
    @department=Department.new(department_params)
    if @department.save
      @department.create_article
      redirect_to department_path(@department), flash: {success: "添加成功"}
    else
      flash[:warning] = "添加部门失败,请重试"
      render 'new'
    end
  end

  private

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

  def department_params
    params.require(:department).permit(:name,:office_address,:office_number,:number_of_people)
  end

end
