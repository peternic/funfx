Feature: Select date
  In order to make a date
  Daters should be able to pick a date for a date
  
  Scenario: Christmas eve
    Given I am on the new date page
    When I select date Dec 24 1971
    Then I should see Dec 25 1971 as my date