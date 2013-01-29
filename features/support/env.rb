$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)

require 'capybara/cucumber'
require 'capybara/persona'
require File.expand_path('../app/app', __FILE__)

Capybara.app = App
Capybara.default_driver = Capybara.javascript_driver
Capybara.default_selector = :css

class TestWorld
  def persona
    @p ||= Capybara::Persona.new(page)
  end
end

World { TestWorld.new }
