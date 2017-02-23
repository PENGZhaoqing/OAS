class ChatsController < ApplicationController
  include SessionsHelper
  respond_to :js, :html
  before_action :logged_in
  before_action :set_chat, except: [:index, :new, :create]

  def index
  end

  def new
  end


  def add_user

  end

  def create
    user=User.find_by_id(params[:users])

    current_user.chats.each do |chat|
      if (chat.users-[user, current_user]).blank?
        redirect_to chat_path(chat)
      end
    end

    @chat = Chat.new
    @chat.users<<user
    @chat.users<<current_user
    @chat.name="#{user.name}-#{current_user.name}"

    if @chat.save
      redirect_to chat_path(@chat)
    else
      flash[:warning] = "错误,请重试"
      render chats_path, flash: flash
    end
  end

  def update
  end

  def destroy
    @chat.destroy
    redirect_to chats_path, flash: {:danger => '聊天已删除'}
  end

  def show
    @messages=[]
    @chat.messages.each do |msg|
      @messages << msg
    end
    @new_message = current_user.messages.build
  end

  private

  def logged_in
    unless logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  def set_chat
    @chat=Chat.find_by_id(params[:id])
    if @chat.nil?
      redirect_to chats_path, flash: {:warning => "没有找到此次聊天的信息"}
    end
  end

end