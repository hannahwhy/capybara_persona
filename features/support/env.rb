require 'capybara/cucumber'
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
