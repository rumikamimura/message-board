class MessagesController < ApplicationController
  before_action :set_message, only: [:edit, :update, :destroy]
  
  def index
     # Messageを全て取得する。
    @messages = Message.all
    @message = Message.new
  end

  ## ここから追記
  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to root_path , notice: 'メッセージを保存しました'
    else
      # メッセージが保存できなかった時
      @messages = Message.all
      flash.now[:alert] = "メッセージの保存に失敗しました。"
      render 'index'
    end
  end
  
  ### ここからさらに追記 8.4
  def edit
  end
  
  def update
    if @message.update(message_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to root_path , notice: 'メッセージを編集しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  ### ここまで 8.4
  
  #### ここからさらに追記 8.7
  def destroy
    @message.destroy
    redirect_to root_path, notice: 'メッセージを削除しました'
  end
  #### ここまで 8.7

  private
  def message_params
    params.require(:message).permit(:name, :body, :age)
  end
  ## ここまで
  
  ### ここからさらに追記 8.4
  def set_message
    @message = Message.find(params[:id])
  end
  ### ここまで 8.4
end