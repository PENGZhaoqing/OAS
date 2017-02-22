class ChatsController < ApplicationController
  include SessionsHelper
  respond_to :js, :html

  def index

  end

  def new
  end

  def shortcut
    user=User.find_by_id(params[:id])
    current_user.chats.each do |chat|
      if (chat.users-[user, current_user]).blank?
        redirect_to chat_path(chat) and return
      end
    end

    @chat = Chat.new
    @chat.users<<user
    @chat.users<<current_user
    @chat.name="与#{user.name}的聊天"

    if @chat.save
      redirect_to chat_path(@chat)
    else
      flash[:warning] = "错误,请重试"
      render 'index'
    end
  end

  def create

  end

  def update

  end

  def destroy

  end

  def show
    @chat=Chat.find_by_id(params[:id])
    @messages=[]
    @chat.messages.each do |msg|
      @messages << msg
    end
    @new_message = current_user.messages.build
  end

end