Given /^the Persona sign-in window is open$/ do
  steps %q{
    When I click "Sign in"
    Then the Persona window appears
  }
end

Given /^I am at "(.*?)"$/ do |path|
  visit path
end

When /^I click "(.*?)"$/ do |name|
  click_button 'Sign in'
end

When /^I provide the email address "(.*?)"$/ do |email|
  persona.set_email(email)
end

When /^I provide the password "(.*?)"$/ do |password|
  persona.set_password(password)
end

When /^I submit my credentials$/ do
  persona.submit_credentials
end

Then /^I am prompted to create a password$/ do
  persona.state.should == :create_password
end

Then /^the Persona window appears$/ do
  persona.should have_visible_window
end

Then /^I am signed in$/ do
  page.should have_content('Signed in')
end
