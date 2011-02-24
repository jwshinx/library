Feature: User Log In

  So that users can log in 
  Access functions of library app

  Scenario: login
    Given a user
    When the user enters password
    Then the user should have the ability to use app
