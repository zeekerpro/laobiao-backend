class Client::MessagesController < ClientController

  before_action :set_chat

  before_action :set_message, only: %i[ show update destroy ]

  # post /chats/:chat_id/messages/sync_detect
  # 同步检测
  # 1. 检测服务端是否有客户端未存储的聊天记录
  # 2. 检测客户端是否有服务端未存储的聊天记录
  def sync_detect
    client_indexed_db_ids = params[:ids]
    messages = @chat.messages
    stored_indexed_db_ids = messages.map(&:indexed_db_id)

    unstored_message_ids = client_indexed_db_ids - stored_indexed_db_ids
    uncached_message_ids = stored_indexed_db_ids - client_indexed_db_ids

    render json: { unstored_message_ids: unstored_message_ids, uncached_message_ids: uncached_message_ids}
  end

  def bulk_create
    messages = params[:messages]
    store_messages = messages.map do |msg|
      {
        chat_id: @chat.id,
        content: msg[:content],
        role: msg[:role],
        indexed_db_id: msg[:id],
        created_at: msg[:created_at] || Time.now,
        updated_at: msg[:updated_at] || Time.now
      }
    end
    Message.insert_all(store_messages)
    render json: { status: :ok }
  end

  # GET /messages
  def index
    @messages = @chat.messages
    render json: @messages.map { |message|
      message.as_json.merge({
        id: message.indexed_db_id,
        chat_id: @chat.indexed_db_id
      })
    }
  end

  # POST /messages
  def create
    @message = Message.new(message_params.except(:id).merge(
      chat_id: @chat.id,
      indexed_db_id: message_params[:id],
      role: 'user'
    ))
    @message.save
    # TODO
    get_openai_response_job = GetOpenaiResponseJob.perform_now(chat_id: @chat.id)
    head :ok
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
  end

  private

    def set_chat
      @chat = current_user.chats.find_by(indexed_db_id: params[:chat_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find_by(indexed_db_id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      # 客户端传的id是indexed_db_id
      params.require(:message).permit(:id, :content, :model_name, :created_at, :updated_at)
    end
end
