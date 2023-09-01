require 'discordrb'


ChannelID = '1146977104240574516'

Bot = Discordrb::Commands::CommandBot.new(
  token: Rails.application.credentials.dig(:discord, :token),
  client_id: Rails.application.credentials.dig(:discord, :client_id),
  prefix: '/',
)

Dir["#{Rails.root}/app/commands/*.rb"].each { |file| require file }

Bot.run(true)

puts "Bot is running! Invite URL: #{Bot.invite_url}"

