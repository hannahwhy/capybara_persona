$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)

require 'capybara/cucumber'
require 'capybara/persona'
require File.expand_path('../app/app', __FILE__)
require File.expand_path('../artifacts', __FILE__)
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

a = Class.new { include Artifacts }.new

at_exit do
  if defined?(RUBY_ENGINE) && RUBY_ENGINE == "ruby" && RUBY_VERSION >= "1.9"
    # See http://bugs.ruby-lang.org/issues/5218.  This is not necessary on
    # newer MRIs, but there's lots of patchlevels out there.
    exit_status = $!.status if $!.is_a?(SystemExit)
    a.archive_artifacts
    exit exit_status if exit_status
  else
    a.archive_artifacts
  end
end

World { TestWorld.new }
