Given /^the Persona sign-in window is open$/ do
  steps %q{
    When I click "Sign in"
    Then the BrowserID window appears
  }
end

Given /^I am at "(.*?)"$/ do |path|
  visit path
  reset_persona_window
end

When /^I click "(.*?)"$/ do |name|
  click_button 'Sign in'
end

When /^I provide the email address "(.*?)"$/ do |email|
  within_persona_window do
    fill_in 'authentication_email', :with => email
    click_button 'next'
  end
end

When /^I provide the password "(.*?)"$/ do |password|
  within_persona_window do
    fill_in 'password', :with => password
  end
end

When /^I provide the verified password "(.*?)"$/ do |password|
  within_persona_window do
    fill_in 'password', :with => password
    fill_in 'vpassword', :with => password
    click_button 'done'
  end
end

Then /^I am prompted to create a password$/ do
  within_persona_window do
    page.should have_content('Please create a password')
  end
end

Then /^I am prompted to check my email$/ do
  within_persona_window do
    page.should have_content('Confirm your email address')
  end
end

Then /^the BrowserID window appears$/ do
  within_persona_window do
    page.should have_content('Persona')
  end
end

Then /^I am logged in$/ do
  pending # express the regexp above with the code you wish you had
end
