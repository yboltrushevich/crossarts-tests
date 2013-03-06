require 'capybara'
require 'capybara/cucumber'
require 'selenium/webdriver'
require 'rspec/expectations'
#require 'capybara-screenshot/cucumber'
require 'faker'
require 'yaml'

Capybara.default_driver = :selenium
Capybara.default_wait_time = 5
Capybara.default_selector = :css
Capybara.app_host = "http://beta.crossexchange.com"#"http://192.168.1.112"

Capybara.register_driver :selenium do |app|
	Capybara::Selenium::Driver.new(app, :browser => :firefox)
end


def screen_shot_and_save_page
  path = File.expand_path(File.dirname(__FILE__) + "/../screenshots/#{Time.now.strftime('%Y-%m-%d-%H-%M-%S')}" )
  page.save_screenshot "#{path}.png"
end
