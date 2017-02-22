class AnnouncementsController < ApplicationController
  include SessionsHelper
  before_action :logged_in

  def index
    @announcements=Article.search(params).paginate(:page => params[:page], :per_page => 10)
  end

  def edit
  end

  def show
    @announcement= Article.find_by_id(params[:id])
  end

  def update

  end

  def destroy
    @announcement = Article.find_by_id(params[:id])
    @announcement.destroy
    redirect_to announcements_path(new: false), flash: {success: "公告已删除"}
  end

  def new
    @announcement=Article.new
  end

  def create
    @announcement=current_user.articles.new(announcement_params)
    if @announcement.save
      redirect_to announcement_path(@announcement), flash: {success: "添加成功"}
    else
      flash[:warning] = "添加公告失败,请重试"
      render 'new'
    end
  end

  private

  def logged_in
    unless logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  def announcement_params
    params[:announcement][:kind]="通知公告"
    params[:announcement][:title]=params[:announcement][:title].gsub(/\s/,"&nbsp;")
    params[:announcement][:content]=params[:announcement][:content].gsub(/\r/,"<br/>").gsub(/\s/,"&nbsp;")
    params.require(:announcement).permit(:title,:content)
  end

end
