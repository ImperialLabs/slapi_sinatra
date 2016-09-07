require 'json'
require 'logger'
require 'slack-ruby-client'

MyApp.add_route('POST', '/v1/attachment', 'resourcePath' => '/Chat',
                                          'summary' => 'Post advanced messages, see https://api.slack.com/docs/message-attachments for more info',
                                          'nickname' => 'attach_message',
                                          'responseClass' => 'array[framework_attachment]',
                                          'endpoint' => '/attachment',
                                          'notes' => '',
                                          'parameters' => [
                                            {
                                              'name' => 'body',
                                              'description' => 'message to post',
                                              'dataType' => 'FrameworkAttachment',
                                              'paramType' => 'body'
                                            }
                                          ]) do
  cross_origin
  # the guts live here

  { 'message' => 'yes, it worked' }.to_json
end

MyApp.add_route('POST', '/v1/emote', 'resourcePath' => '/Chat',
                                     'summary' => 'Emote in chatroom',
                                     'nickname' => 'emote_message',
                                     'responseClass' => 'array[framework]',
                                     'endpoint' => '/emote',
                                     'notes' => '',
                                     'parameters' => [
                                       {
                                         'name' => 'body',
                                         'description' => 'message to post',
                                         'dataType' => 'Framework',
                                         'paramType' => 'body'
                                       }
                                     ]) do
  cross_origin
  # the guts live here

  { 'message' => 'yes, it worked' }.to_json
end

MyApp.add_route('POST', '/v1/formatted', 'resourcePath' => '/Chat',
                                         'summary' => 'Post in basic formatted text "*bold* `code` _italic_ ~strike~"',
                                         'nickname' => 'format_message',
                                         'responseClass' => 'array[framework]',
                                         'endpoint' => '/formatted',
                                         'notes' => '',
                                         'parameters' => [
                                           {
                                             'name' => 'body',
                                             'description' => 'message to post',
                                             'dataType' => 'Framework',
                                             'paramType' => 'body'
                                           }
                                         ]) do
  cross_origin
  # the guts live here

  { 'message' => 'yes, it worked' }.to_json
end

MyApp.add_route('GET', '/v1/speak', 'resourcePath' => '/Chat',
                                    'summary' => 'Post in chatroom',
                                    'nickname' => 'post_message',
                                    'responseClass' => 'array[framework]',
                                    'endpoint' => '/speak',
                                    'notes' => '',
                                    'parameters' => [
                                      {
                                        'name' => 'body',
                                        'description' => 'message to post',
                                        'dataType' => 'Framework',
                                        'paramType' => 'body'
                                      }
                                    ]) do
  cross_origin
  logger.info('speak was called')

  Slack.configure do |config|
    config.token = settings.SLACK_API_TOKEN
    fail 'Missing SLACK_API_TOKEN configuration!' unless config.token
  end

  client = Slack::Web::Client.new

  #client.auth_test
  client.chat_postMessage(channel: '#test_room',
                          text: 'Hello World everbodeeeee!',
                          as_user: true)
  logger.info('posted to room')
  status 200

  { 'message' => 'yes, it worked' }.to_json
end
