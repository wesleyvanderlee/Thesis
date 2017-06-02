# Mobile Application Security: An assessment of bunq's financial app

## Useful Links:
+ [project code](https://github.com/bunqcom/fsm-learner)

+ [STRE group to make it work](https://github.com/TUDelft-CS4110/2016-sre-crew)

+ [missing script](https://github.com/wesleyvanderlee/Thesis/blob/master/Literature/BSc.%20FSM%20Learner/make_dump.sh)

## Modifications

Looking at the BSc. [project code](https://github.com/bunqcom/fsm-learner), trying to make it work shows that other applications are required to be installed (brew, nodeJS, Appium, maven). Configured a virtualized environment that contained these dependencies. The BSc. Project tool has 4 options:
    1. _learn_
    2. _alphabet:create_
    3. _alphabet:compose_
    4. _alphabet:destroy_

To make the application work again, a number of modifications were required. They each have been discussed [here](https://github.com/wesleyvanderlee/Thesis/blob/master/Literature/BSc.%20FSM%20Learner/Modifications.md).

## Issues
  1. Time: smarter reset (back / actions reversed)
  2. Alphabet: Lacking swiping; system actions (back)

// This has been written with the intent that L* has already been introduced, such that is known: learner - teacher setup; basic interaction queries, counterexample treatments. 
## Current Situation
The goal of the fsm-learner is to abstract the behavior of a mobile application in terms of a finite state machine (fsm) with Angluin's L* algorithm. The fsm generally models what combinations of input gives certain states. The inputs are determined from the application's user interface (UI) and are either buttons to click, textarea's to edit text and checkboxes to check. The minimally adequate teacher (MAT) from Angluins L*, interacts through an intermediate layer to the application: Appium. The learner from Angluin's L*, asks membership queries for combinations of inputs and equivalence queries for a modeled fsm. The membership queries are answered by the MAT upon a successful execution by Appium. Conjectures are tested by utilization of a random walk equilavence oracle, which performs a random execution sequence over the conjecture and terminates after a fixed number of steps or establishes a counterexample.
