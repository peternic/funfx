Feature: Select date
  In order to make a date
  Daters should be able to pick a date for a date
  
  Scenario: Christmas eve
    Given I am on the new date page
    When I select date Feb 28 1971
    Then I should see Feb 28 1972 as my date