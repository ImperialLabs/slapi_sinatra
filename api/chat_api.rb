require 'json'
require 'logger'
require 'slack-ruby-client'



class MyApp < Sinatra::Base

  def initialize
    Slack.configure do |config|
      config.token = settings.SLACK_API_TOKEN
      raise 'Missing SLACK_API_TOKEN configuration!' unless config.token
    end

    @client = Slack::Web::Client.new
    @client.auth_test
  end


  # Handles a POST request for '/v1/attachment'
  # 
  #
  # @param request [Request] the request object
  # @return [String] the resulting webpage
  post '/v1/attachment' do
    logger.info('attach was called')
    @client.chat_postMessage(
      channel: '#test_room',
      text: 'Hello World',
      as_user: true,
      attachments: [
        {
          fallback: "New ticket from Andrea Lee - Ticket #1943: Can't rest my password - https://groove.hq/path/to/ticket/1943",
          pretext: "New ticket from Andrea Lee",
          title: "Ticket #1943: Can't reset my password",
          title_link: "https://groove.hq/path/to/ticket/1943",
          text: "Help! I tried to reset my password but nothing happened!",
          color: "#7CD197"
        }
      ].to_json
    )
    logger.info('attached to room')
    status 200

    { 'message' => 'yes, it worked' }.to_json
  end

  post '/v1/emote' do
    logger.info('emote was called')
    # interestingly... this did not work with name of room, only ID
    @client.chat_meMessage(channel: 'C27MR7Y03',
                          text: 'dances a jig')
    logger.info('posted to room')
    status 200
    { 'message' => 'yes, it worked' }.to_json
  end


  post '/v1/speak' do
    logger.info('speak was called')
    @client.chat_postMessage(channel: params[:channel],
                            text: '*Hello* `World` ~everbodeeeee~',
                            as_user: true)
    logger.info('posted to room')
    status 200
    { 'message' => 'yes, it worked' }.to_json
  end
end
