Given /^the email address "(.*?)" uses password "(.*?)"$/ do |email, password|
  steps %Q{
    When I provide the email address "#{email}"
    And I provide the verified password "#{password}"
    Then I am prompted to check my email
  }

  db = Authdb.new
  tokens = db.verification_tokens_for(email)
  token = tokens.last

  raise "Verification token not found" unless token

  `curl http://localhost:10002/verify_email_address?token=#{token}`
end
