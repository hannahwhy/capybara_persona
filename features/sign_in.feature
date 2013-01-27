Feature: Signing in
  Scenario: Clicking the sign in button
    Given I am at "/"

    When I click "Sign in"

    Then the BrowserID window appears

# vim:ts=2:sw=2:et:tw=78
