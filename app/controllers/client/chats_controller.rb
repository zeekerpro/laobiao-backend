class Client::ChatsController < ClientController

  before_action :set_chat, only: %i[ show update destroy ]

  # 同步检测
  # 1. 检测服务端是否有客户端未存储的聊天记录
  # 2. 检测客户端是否有服务端未存储的聊天记录
  def sync_detect
    client_indexed_db_ids = params[:ids]
    chats = current_user.chats
    stored_indexed_db_ids = chats.map(&:indexed_db_id)

    unstored_chat_ids = client_indexed_db_ids - stored_indexed_db_ids
    uncached_chat_ids = stored_indexed_db_ids - client_indexed_db_ids

    render json: { unstored_chat_ids: unstored_chat_ids, uncached_chat_ids: uncached_chat_ids}
  end

  # GET /chats
  def index
    chats = params[:ids] ? Chat.where(indexed_db_id: params[:ids]) : Chat.all
    client_chats = chats.map do | chat |
      {
        id: chat.indexed_db_id,
        name: chat.name,
        created_at: chat.created_at,
        updated_at: chat.updated_at,
      }
    end

    render json: client_chats
  end

  # GET /chats/1
  def show
    render json: @chat
  end

  def bulk_create
    chats = params[:chats]
    store_chats = chats.map do |chat|
      {
        user_id: current_user.id,
        api_key_id: chat[:api_key_id] || ApiKey.default.id,
        name: chat[:name],
        indexed_db_id: chat[:id],
        created_at: chat[:created_at] || Time.now,
        updated_at: chat[:updated_at] || Time.now
      }
    end
    Chat.insert_all(store_chats)
    render json: { status: :ok }
  end

  # POST /chats
  def create
    @chat = Chat.new(chat_params)

    if @chat.save
      render json: @chat, status: :created, location: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chats/1
  def update
    if @chat.update(chat_params)
      render json: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chats/1
  def destroy
    @chat.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chat_params
      params.require(:chat).permit(:user_id, :api_key_id, :name, :created_at, :updated_at)
    end
end
