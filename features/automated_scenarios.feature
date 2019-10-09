Feature: Scenarios for test task

  Background:
    Given I open website hh.ru

  Scenario: Search company by name
    When I search company новые облачные
    Then I should see search result for Новые Облачные Технологии

  Scenario: Check count of vacancies for current company by region
    When I open Новые Облачные Технологии company page
    Then I should see 10 vacancies for current region

  Scenario: Check vacancy by name
    When I open Новые Облачные Технологии company page
    And I open vacancies for current region
    Then I should see QA Automation Engineer vacancy

