module Integrations
  module Discord

    module Commands
      module Ping
        extend Discordrb::Commands::CommandContainer

        Integrations::Discord::Bot.message(content: 'Ping!') do |event|
          event.respond 'Message Pong!'
        end

        Integrations::Discord::Bot.command :ping do |event|
          event.respond 'Command Pong!'
        end

      end
    end

  end

end

