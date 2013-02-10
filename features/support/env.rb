$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)

require 'capybara/cucumber'
require 'capybara/persona'
require File.expand_path('../app/app', __FILE__)

Capybara.app = App
Capybara.default_wait_time = 60
Capybara.default_selector = :css

class TestWorld
  def persona
    @p ||= Capybara::Persona.new(page)
  end
end

Before do
  driver = case ENV['DRIVER']
           when 'chrome' then :chromedriver
           else :selenium
           end

  Capybara.current_driver = driver
end

$STEP = 0

require 'fileutils'
require 'aws/s3'
include FileUtils

AfterStep do
  mkdir_p '/tmp/shots'
  `import -window root #{$STEP}.png`
  $STEP += 1
end

at_exit do
  Dir.chdir('/tmp') do
    `tar zcvf shots.tar.gz shots`
  end

  AWS::S3::Base.establish_connection!(
    :access_key_id => ENV['ACCESS_KEY_ID'],
    :secret_access_key => ENV['SECRET_ACCESS_KEY']
  )

  include AWS::S3

  AWS::S3::S3Object.store(archive, open('/tmp/shots.tar.gz'), 'shots.tar.gz')
end

After do
  click_button 'Sign in'
  persona.logout
end

World { TestWorld.new }
