require 'json'
require 'logger'
require 'slack-ruby-client'



class MyApp < Sinatra::Base

  post '/v1/attachment' do
    logger.info('attach was called')

    Slack.configure do |config|
      config.token = settings.SLACK_API_TOKEN
      raise 'Missing SLACK_API_TOKEN configuration!' unless config.token
    end

    client = Slack::Web::Client.new

    client.auth_test
    client.chat_postMessage(
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

    #cross_origin
    logger.info('emote was called')

    Slack.configure do |config|
      config.token = settings.SLACK_API_TOKEN
      raise 'Missing SLACK_API_TOKEN configuration!' unless config.token
    end

    client = Slack::Web::Client.new

    client.auth_test
    begin
      # interestingly... this did not work with name of room, only ID
      client.chat_meMessage(channel: 'C27MR7Y03',
                            text: 'dances a jig')
    rescue => detail
      logger.info(detail.backtrace.join("\n"))
    end
    logger.info('posted to room')
    status 200

    { 'message' => 'yes, it worked' }.to_json
  end

  post '/v1/speak' do
    #cross_origin
    logger.info('speak was called')

    Slack.configure do |config|
      config.token = settings.SLACK_API_TOKEN
      raise 'Missing SLACK_API_TOKEN configuration!' unless config.token
    end

    client = Slack::Web::Client.new

    #client.auth_test
    client.chat_postMessage(channel: '#test_room',
                            text: '*Hello* `World` ~everbodeeeee~',
                            as_user: true)
    logger.info('posted to room')
    status 200

    { 'message' => 'yes, it worked' }.to_json
  end
end
