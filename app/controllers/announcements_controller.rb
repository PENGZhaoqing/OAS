class AnnouncementsController < ApplicationController
  include SessionsHelper
  before_action :logged_in

  def index
    params[:kind]="通知公告"
    @announcements=Article.search(params).paginate(:page => params[:page], :per_page => 10)
  end

  def edit
    @announcement= Article.find_by_id(params[:id])
    @announcement[:title]=@announcement[:title].gsub('&nbsp;',' ')
    @announcement[:content]=@announcement[:content].gsub('<br/>',"\n").gsub('&nbsp;',' ')
  end

  def show
    @announcement= Article.find_by_id(params[:id])
  end

  def update
    @announcement= Article.find_by_id(params[:id])
    if @announcement.update_attributes(announcement_params)
      flash={:info => "更新成功"}
    else
      flash={:warning => "更新失败"}
    end
    redirect_to announcements_path, flash: flash
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
    params[:article][:kind]="通知公告"
    params[:article][:title]=params[:article][:title].gsub(/\s/,"&nbsp;")
    params[:article][:content]=params[:article][:content].gsub(/\r/,"<br/>").gsub(/\s/,"&nbsp;")
    params.require(:article).permit(:title,:content,:kind)
  end


end
