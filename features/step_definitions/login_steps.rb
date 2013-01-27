Given /^the Persona sign-in window is open$/ do
  steps %q{
    When I click "Sign in"
    Then the BrowserID window appears
  }
end

Given /^I am at "(.*?)"$/ do |path|
  visit path
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

Then /^I am prompted to create a password$/ do
  within_persona_window do
    page.should have_content('Please create a password')
  end
end

Then /^the BrowserID window appears$/ do
  within_persona_window do
    page.should have_content('Persona')
  end
end
