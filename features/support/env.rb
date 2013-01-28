require 'capybara/cucumber'
require File.expand_path('../app/app', __FILE__)

Capybara.default_selector = :css
Capybara.app = App

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.default_driver = :selenium_chrome
