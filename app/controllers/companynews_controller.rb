class CompanynewsController < ApplicationController
  include SessionsHelper
  before_action :logged_in

  def index
    params[:kind]="公司新闻"
    @manycompanynews=Article.search(params).paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @companynews= Article.find_by_id(params[:id])
  end

  def new
    @companynews=Article.new
  end

  def create
    @companynews=current_user.articles.new(companynews_params)
    if @companynews.save
      redirect_to companynews_index_path(@companynews), flash: {success: "添加成功"}
    else
      flash[:warning] = "添加新闻失败,请重试"
      render 'new'
    end
  end

  def edit
    @companynews= Article.find_by_id(params[:id])
    @companynews[:title]=@companynews[:title].gsub('&nbsp;',' ')
    @companynews[:content]=@companynews[:content].gsub('<br/>',"\n").gsub('&nbsp;',' ')
  end

  def update
    @companynews= Article.find_by_id(params[:id])
    if @companynews.update_attributes(companynews_params)
      flash={:info => "更新成功"}
    else
      flash={:warning => "更新失败"}
    end
    redirect_to companynews_index_path, flash: flash
  end

  def destroy
    @companynews = Article.find_by_id(params[:id])
    @companynews.destroy
    redirect_to companynews_index_path(new: false), flash: {success: "新闻已删除"}
  end

  private

  def logged_in
    unless logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  def companynews_params
    params[:article][:kind]="公司新闻"
    params[:article][:title]=params[:article][:title].gsub(/\s/,"&nbsp;")
    params[:article][:content]=params[:article][:content].gsub(/\r/,"<br/>").gsub(/\s/,"&nbsp;")
    params.require(:article).permit(:title,:content,:kind)
  end
end
