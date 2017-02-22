class MessagesController < ApplicationController
  include SessionsHelper
  before_action :set_message, only: [:update, :destroy]

  def create
    @message = current_user.messages.build(message_params)
    chat=Chat.find_by_id(params[:chat_room])
    redirect_to chats_path, flash: {:warning => "此聊天不存在"} and return if chat.nil?
    @message.chat=chat
    if @message.save
      sync_new @message
    else
      redirect_to chat_path(chat), flash: {:warning => "消息发送失败"} and return
    end
    redirect_to chat_path(chat)
  end

  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end

# def update
#   respond_to do |format|
#     if @message.update(message_params)
#       format.html { redirect_to @message, notice: 'Message was successfully updated.' }
#       format.json { render :show, status: :ok, location: @message }
#     else
#       format.html { render :edit }
#       format.json { render json: @message.errors, status: :unprocessable_entity }
#     end
#   end
# end
