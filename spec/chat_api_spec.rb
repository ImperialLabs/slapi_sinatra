require 'capybara/rspec'
require_relative '../my_app.rb'
Capybara.app = MyApp

describe 'call the speak API', :type => :feature do
  it 'returns' do
    visit '/v1/speak'
    expect(page).to have_content 'Success'
  end
end

describe 'call the emote API', :type => :feature do
  it 'returns' do
    page.driver.post '/v1/emote'
    expect(page).to have_content 'Success'
  end
end

describe 'call the attach API', :type => :feature do
  it 'returns' do
    page.driver.post '/v1/attachment'
    expect(page).to have_content 'Success'
  end
end
