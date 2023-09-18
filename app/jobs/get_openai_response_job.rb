class GetOpenaiResponseJob < ApplicationJob
  queue_as :default

  def perform(chat_id:)
    chat = Chat.find(chat_id)
    call_openai(chat: chat)
  end

  private

  def call_openai(chat:)

    response_message = chat.messages.create(role: "assistant", content: "")

    client = OpenAI::Client.new(
      access_token: Rails.application.credentials.openai.api_key,
      uri_base: "https://oai.hconeai.com/",
      request_timeout: 240,
      extra_headers: {
        "X-Proxy-TTL" => "43200",
        "X-Proxy-Refresh": "true",
        "Helicone-Auth": "Bearer #{Rails.application.credentials.helicorn.api_key}",
        "helicone-stream-force-format" => "true",
      }
    )

    openai_response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo-16k",
        messages: chat.messages_for_openai,
        temperature: 0.7,
        stream: stream_proc(response_message: response_message)
      }
    )

  end

  def stream_proc(response_message:)
    proc do | chunk, _bytesize |
      new_content = chunk.dig("choices", 0, "delta", "content")
      response_message.update(content:  response_message.content + new_content) if new_content

      ActionCable.server.broadcast("openai", { data: new_content })
    end
  end

end
