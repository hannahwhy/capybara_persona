Capybara.register_driver :chromedriver do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end
