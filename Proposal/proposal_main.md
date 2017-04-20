# Research Proposal

# Introduction
Android applications can be found everywhere, ranging from mobile phones to smart televisions and -ovens. Programming these applications is a task prone to errors, as bugs and vulnerabilities lurk around the corner. The impact of these bugs and vulnerabilities can range from application downtime, i.e. crashes, to the compromise of information or the system itself. Aiding the process of identifying these bugs and vulnerabilities, comes application model inference in a black box manner.
Model inference has proven to be a valuable asset in the field of protocol conformance testing of various implementation, such as TLS implementations [1] or the behavior of the Dutch Biometric Passport Chip [2]. To a limited extend, model inference has been applied to mobile applications [3]. The applied techniques are however in some cases circuitous and resulted in a learning-wise time expensive algorithm.

## Relevant Research
See the documentation [here](Literature/README.md).

## Research Questions

+ RQ1: How can we apply state machine learning to mobile applications?

+ RQ2: How can we best combine fuzzing and machine learning to hypothesize a functional state machine diagram?

+ RQ3: How can we apply fuzzing and learning on Android applications in a time-feasible way?

#### RQ1
How to define a state (UI-wise)?
	+ I.e. scrape frames, links, etc. Based on layout alone?
	+ How does this follow from the relevant literature?
How to define equivalence (in case of dynamic representation), some scrape the UI-a-hrefs. Depends on how the state is defined.

#### RQ2
Leads to the following model:

![Proposal Setup Diagram](https://github.com/wesleyvanderlee/Thesis/blob/master/Proposal/Proposal%20Setup.png)

Figure 1.

EMMA needs to be configured into the application's manifest, in order to enable the code coverage function based on app behavior. From two perspectives this may be possible, during:
	+ app development.
	+ app decompile, change the manifest, recompile.

#### RQ3
Using speed-up mechanisms.
	Smarter learning algorithm.
	Fuzz- and test-case selection, etc.

## Methodology
A process for inferring state machines of Android applications shall be developed and a proof of concept tool shall be developed accordingly. The process and the tool must adhere to a 'smart' learning process, meaning the process adheres to the correctness and time-feasibility requirements. The research project refines to the following research tasks:
	1. Understand model learning algorithms and diverse fuzzing techniques. Also depict different applications of model learning.
	2. Consider how 1 can be applied to the mobile testing environment.
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
