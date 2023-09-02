class Client::DiscordsController < ClientController

  def create
    message = "
      A new post has been created!
      title: test title
      youtube: https://www.youtube.com/watch?v=9bZkp7q19f0
    "
    Intergrations::Discord::Bot.send_message(Intergrations::Discord::ChannelID, message)
  end

end
