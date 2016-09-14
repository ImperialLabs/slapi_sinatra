require 'capybara/rspec'
require_relative '../my_app.rb'
Capybara.app = MyApp

describe 'call the speak API', type: :feature do
  it 'returns' do
    page.driver.post '/v1/speak', channel: '#test_room'
    expect(page).to have_content 'it worked'
  end
end

describe 'call the emote API', type: :feature do
  it 'returns' do
    page.driver.post '/v1/emote'
    expect(page).to have_content 'it worked'
  end
end

describe 'call the attach API', type: :feature do
  it 'returns' do
    page.driver.post '/v1/attachment'
    expect(page).to have_content 'it worked'
  end
end
