Feature: require'ing the Libraries.

  Since some of these helpers are opinionated, we have tried to allow you to pick and choose which sets to use.

  In order to allow reduce dependencies and 
  A developer 
  Wants to select only those helpers that they need

  Scenario: The Whole Kitchen Sink
    When I require "cucumber-passi/step_definitions"
    Then these libraries should be loaded:
      | Passi::StepHelpers | true |

