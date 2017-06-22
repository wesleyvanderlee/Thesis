# Research Proposal

# Introduction
Android applications can be found everywhere, ranging from mobile phones to smart televisions and -ovens. Programming these applications is a task prone to errors, as bugs and vulnerabilities continuously lurk around the corner. The impact of these bugs and vulnerabilities can range from application downtime, i.e. crashes, to the compromise of information or the system itself. Aiding the process of identifying these bugs and vulnerabilities, come state of the art testing techniques such as application model inference in a black box manner.
Model inference deals with modeling the behavior of a System Under Test (SUT) in the form of an automaton. The automaton gives a graphical overview of the SUT's logic, which can be used as a new source to identify bugs and vulnerabilities in the system. Model inference has proven to be a valuable asset in the field of protocol conformance testing of various implementation, such as TLS implementations [1] or the behavior of the Dutch Biometric Passport Chip [2]. To a limited extend, model inference has been applied to mobile applications [3]. The applied techniques are however in some cases circuitous and resulted in a learning-wise time expensive algorithm.

## Relevant Research
See the documentation [here](Literature/README.md).

## Research Questions


+ RQ1: How can we extent model learning for mobile applications?
  - How to deal with mobile parameters (i.e. loss of Internet connectivity)
	- How are states defined in mobile applications?
	- How to define a complete alphabet in mobile applications?
		- Input: more than only buttons in the application.

+ RQ2: How can we improve the feasibility of mobile application learning.
	- Can hard resetting be substituted by miscellaneous actions?
	- Can the observation table be prefilled with valid information?
			- From fuzzers for buggy states?
			- From an event-tree for normal use completeness.

+ RQ3: How can the learned model be used to assess the application's security?
	- How can bugs and vulnerabilities be identified from the model?
	- How can the model be enriched to further assess the security.



## Planning
** RQ1 **
[] Be able to model applications based on GUI elements.
	Start: 1 April; End: 30 June
[] Extent the input and output alphabet and deal with learning errors.
	Start: 1 July; End: 15 July

** RQ2 **
[] Increase time feasibility by adoption of: caching/event-filling/other smart techniques.
	Start: 1 August; End: 31 August

** RQ3 **
[] Assess for a set of bugs and vulnerabilities if they can be identified in (enriched) graphs.
	Start: 1 September; End: 7 September
[] Formalize algorithms how they can be derived.
	Start: 7 September; End: 30 September

** Validation **
Validate Correctness
[] Create application that contains the vulnerabilities
	Start: 1 October; End: 7 October
[] Assert the tool on the application and assess results
	Start: 7 October; End: 14 October
Validate Metrics:
[] Assert the tool on available applications (i.e. from Play Store)
	Start: 14 October; End: 30 October

** Report **
[] Finalize report and create final presentation
	Start: 1 November; End: 30 November





############OLD########################
///////////////////////////////////////
+ RQ1: How can we effectively learn and model mobile applications?
			- How are states defined in mobile applications?
			- How to define a complete alphabet in mobile applications?
+ RQ2: How can we improve the feasibility of application model inference.
			- Can hard resetting be substituted by miscellaneous actions?
			- Can the observation table be prefilled with valid information?
					- Maybe from an event-tree.

############OLD########################
///////////////////////////////////////

## Methodology
A process for inferring state machines of Android applications will be developed and a proof of concept tool shall be developed accordingly. The process and the tool must adhere to a 'smart' learning process, meaning the process adheres to the correctness and time-feasibility requirements. The research project refines to the following research tasks:
	1. Understand model learning algorithms. Also depict different applications of model learning.
	2. Consider how 1. can be applied to the mobile testing environment.
	3. Define use cases for model learning to the cyber security domain.
	4. Establish the process like depicted in Figure 1.
	4. Implement the process to a proof-of-concept.
	5. Perform a survey and experimentation of the application of the proof-of-concept against different applications.
	7. Analyze the results, enter the validity phase and answer the research questions.

## Validation
Test this on an application where the state can also be manually be inferred. Verify both results, spot any differences. Moreover the proof-of-concept of this process, can also be compared to [the Bunq's FSM learner](http://repository.tudelft.nl/islandora/object/uuid%3A37e87645-09a3-4ace-b9b2-dad897292ac9?collection=education).

## References
[1] De Ruiter, Joeri, and Erik Poll. "Protocol State Fuzzing of TLS Implementations." USENIX Security. Vol. 15. 2015.

[2] Aarts, Fides, Julien Schmaltz, and Frits Vaandrager. "Inference and abstraction of the biometric passport." Leveraging Applications of Formal Methods, Verification, and Validation (2010): 673-686.

[3] Mobile Application Security: An assessment of bunq's financial app, Lampe, K.Q. Kraaijeveld, J.C.M. Den Braber, T.D., 2015.
