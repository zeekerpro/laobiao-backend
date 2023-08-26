class Client::ChatsController < ClientController

  skip_before_action :authenticate_user

  include ActionController::Live

    def stream

      client = OpenAI::Client.new(
        access_token: "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",
        uri_base: "https://oai.hconeai.com/",
        request_timeout: 240,
        extra_headers: {
          # For https://github.com/6/openai-caching-proxy-worker#specifying-a-cache-ttl
          "X-Proxy-TTL" => "43200",
          # For https://github.com/6/openai-caching-proxy-worker#refreshing-the-cache
          "X-Proxy-Refresh": "true",
          # For https://docs.helicone.ai/getting-started/integration-method/openai-proxy
          "Helicone-Auth": "Bearer sk-tvx33la-uoqu2wi-x6heunq-37lvtlq",
          # Use this with Helicone otherwise streaming drops chunks # https://github.com/alexrudall/ruby-openai/issues/251
          "helicone-stream-force-format" => "true",
        }
      )

      sse = SSE.new(response.stream)

      openai_response = client.chat(
        parameters: {
          model: "gpt-3.5-turbo-16k",
          messages: [{ role: "user", content: "Hello! 请写一篇800字的作文，主体是热水"}],
          temperature: 0.7,
          stream: proc do | chunk, _bytesize |
            sse.write(chunk.dig("choices", 0, "delta", "content"))
          end
        }
      )

      sse.close

    end

end
