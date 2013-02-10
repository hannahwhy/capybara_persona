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
  persona.should be_asking_to_create_password
end

Then /^the Persona window appears$/ do
  persona.should have_visible_window
end
