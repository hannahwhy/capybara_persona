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

Then /^I am signed in$/ do
  page.should have_content('Signed in')
end

Then /^I am not signed in$/ do
  page.should_not have_content('Signed in')
end
