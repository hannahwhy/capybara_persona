Feature: Signing in
  Background:
    Given I am at "/"

  Scenario: Clicking the sign in button
    When I click "Sign in"

    Then the BrowserID window appears

  Scenario: Registering a new email address
    Given the Persona sign-in window is open

    When I provide the email address "test@example.org"

    Then I am prompted to create a password

  Scenario: Logging in
    Given the Persona sign-in window is open
    And the email address "test@example.org" uses password "password"

    When I provide the email address "test@example.org"
    And I provide the password "password"

    Then I am logged in

# vim:ts=2:sw=2:et:tw=78
