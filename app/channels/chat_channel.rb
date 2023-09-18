class ChatChannel < ApplicationCable::Channel

  def subscribed
    stream_from "openai"
  end

  # def receive(data)
  #   Rails.logger.info "ChatChannel#receive: #{data.inspect}"
  # end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

end
