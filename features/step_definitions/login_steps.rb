Given /^I am at "(.*?)"$/ do |path|
  visit path
end

When /^I click "(.*?)"$/ do |name|
  click_button 'Sign in'
end

Then /^the BrowserID window appears$/ do
  sleep 10
end
