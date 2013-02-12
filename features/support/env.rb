$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)

require 'capybara/cucumber'
require 'capybara/persona'
require File.expand_path('../app/app', __FILE__)
require File.expand_path('../browserid', __FILE__)

Capybara.app = App
Capybara.default_selector = :css

class TestWorld
  include BrowserID

  def persona
    @p ||= Capybara::Persona.new(page)
  end
end

Before do
  setup_browserid_authdb
  wait_for_browserid
end

Before do
  driver = case ENV['DRIVER']
           when 'chrome' then :chromedriver
           else :selenium
           end

  Capybara.current_driver = driver
end

After do
  click_button 'Sign in'
  persona.logout
end

World { TestWorld.new }
