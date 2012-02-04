cucumber-passi: cucumber steps
===============

passi? http://translate.google.com/#auto|it|steps

A collection of helper methods and reusable steps for cucumber[http://cukes.info]: the
acceptance testing library.

Since some of these helpers are opinionated, we have tried to allow you to pick and choose which sets to use.

These steps are used daily in existing projects.

Usage:
======
    $ require 'cucumber-passi/step_definitions'
    $ require 'cucumber-passi/step_definitions/rails'
    $ require 'cucumber-passi/step_definitions/active_record'


Detesteable?
============

(adj.) offensive to the mind
(adj.) that which is not tested

These steps and helpers were extracted from existing projects.  They will live in the detestable dir until they have tests.


Conventions:
============

Specific Instance Naming Convention:
------------------------------------
It is difficult to reference a specific model instance in a step.  Our answer is a naming convention.  Model:model_identifier.
These are (will be?) included in separate files, so you can easily except(thesaurus) them.
    $ require 'cucumber-passi/step_definitions/instance_naming'



Rails Helpers:
--------------
    $ require 'cucumber-passi/step_definitions/rails'


TODO
=====
* More specs.  
* Minimize/compartmentalize/remove dependency on FactoryGirl.
