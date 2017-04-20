# Literature Overview

The following literature has been read:

1. [Combining Learning with Fuzzy for Software Deobfuscation, Janssen M. et al., 2016.](#literature1)
2. [Mobile Application Security: An assessment of bunq's financial app, Lampe, K.Q. Kraaijeveld, J.C.M. Den Braber, T.D., 2015. ](#literature2)
3. [Smetsers, Rick, et al. "Complementing Model Learning with Mutation-Based Fuzzing." arXiv preprint arXiv:1611.02429 (2016). ](#literature3)
4. [De Ruiter, Joeri, and Erik Poll. "Protocol State Fuzzing of TLS Implementations." USENIX Security. Vol. 15. 2015.](#literature4)
5. [Aarts, Fides, Julien Schmaltz, and Frits Vaandrager. "Inference and abstraction of the biometric passport." Leveraging Applications of Formal Methods, Verification, and Validation (2010): 673-686.](#literature5)
6. [Hammerschmidt, Christian Albert, et al. "Interpreting Finite Automata for Sequential Data." arXiv preprint arXiv:1611.07100 (2016).](#literature6)
7. [Vaandrager, Frits. "Model learning." Communications of the ACM 60.2 (2017): 86-95.](#literature7)

### Summaries

#### <a id="literature1"></a> 1. Combining Learning with Fuzzy for Software Deobfuscation [source](http://repository.tudelft.nl/islandora/object/uuid:6282cd05-6ae3-4f39-adc7-1a45efe1ccce?collection=education)

#### <a id="literature2"></a> 2. Mobile Application Security: An assessment of Bunq's financial app [source](http://repository.tudelft.nl/islandora/object/uuid%3A37e87645-09a3-4ace-b9b2-dad897292ac9?collection=education)
Looking at the BSc. [project code](https://github.com/bunqcom/fsm-learner), trying to make it work shows that other applications are required to be installed (brew, nodeJS, Appium, maven). Configured a virtualized environment that contained these dependencies. The BSc. Project tool has 4 options:
    1. _learn_
    2. _alphabet:create_
    3. _alphabet:compose_
    4. _alphabet:destroy_

Before learning can be started an alphabet must be created and composed. After inspecting the code, this has been achieved by parsing XML screens.
Class com.bunq.main.Main with method runAlphabetScript on line 171 invokes a bash-script (scripts/make_dump.sh)  partly responsible of the process above. The script is not present on the public repository. After observing what the script does and attempting to create one myself, I contacted one of the developers of the BSc. Project (Tom den Braber) who shared the script via e-mail. The following is the missing script:

```bash
args=($@)
FILENAME=${args[0]}
adb shell uiautomator dump
echo ${FILENAME}
adb pull /storage/emulated/legacy/window_dump.xml alphabet/window_dumps/$FILENAME   
```
Note: The script was called with Java’s Runtime.exec() method. At this point I do not understand why the 2 commands listed in the bash-script weren’t executed like that, instead of running the script.

A group of students also attempted to modify the code, which was documented here: https://github.com/TUDelft-CS4110/2016-sre-crew.  Asking one of the authors who would want to make the application work again, yielded nothing useful, because the modified code wasn’t present anymore. Following their fixes proposed in the final report, resulted in a large part of the application that has been bypassed and would thus not suit the purpose of making the application work for general applications.

At this point trying to make the code work, is deemed too much of an effort with regards to the too low gain.

#### <a id="literature3"></a> 3. Complementing Model Learning with Mutation-Based Fuzzing [source](https://arxiv.org/pdf/1611.02429.pdf)
In Complementing Model Learning with Mutation-Based Fuzzing Smetsers et al. compare conformance testing and mutation-based fuzzing methods as a way to find counterexamples for the minimally Adequate Teacher framework. This framework results from Angluin's L* algorithm, that enables one to treat software as a black-box and learn its state model. Conformance testing establishes an equivalence relation between current hypothesis and target. This equivalence is tested with a set of test queries and if one query fails, the hypothesis is refuted and can be refined.  Mutation-based fuzzing combined with a genetic evolutionary algorithm has also been used, where the evolutionary algorithm asserts a fitness test to the queries. In this case, code coverage has been linked to the fitness test, meaning that the more code coverage a counterexample has, the fitter it is. For different problems, linear temporal logic and reachability, different fuzzing and model learning yield partially complementary results, which leads to believe that these orthogonal approaches aid each other.

#### <a id="literature4"></a> 4. Protocol State Fuzzing of TLS Implementations
This paper describes the analysis of TLS implementation by a process called 'protocol state fuzzing' that actively infers the state machine of an TLS implementation. A modified version of Angluin's L* algorithm and an improved version of Chow’s W-method were used. The W-method was modified by adding a check to see if it makes sense to continue searching for counterexamples with a particular prefix, as after the TLS connection is closed, it would not be useful anymore. This reduced the number of equivalence queries needed by over 15 times. Model analysis is done manually where first all possible paths to the secure end state is calculated and second the number of superfluous states and transitions. This way of testing showed that three out of the nine tested TLS implementations contained flaws.

#### <a id="literature5"></a> 5. Inference and abstraction of the biometric passport
This paper applies regular inference of state machines to the Biometric Passport. Moreover it proposes an abstraction technique to reduce alphabet and large data sets. This technique embodies the creation of a transducer between the learner and the teacher in the inference process. This transducer is created by compiling a priori data about the system under test (SUT) and maps input data to a more abstract input class. This reduced the potentially large or infinite input alphabet to a smaller and compact one, which results in less transitions and likely less state space. Validation of the inferred model is done by comparing it to the model that has been developed by hand per documentation of the chip. One thing that stands out is that abstracting the model by hand took a team 5 hours while learning the model took only 1 hour. The chip limits transactions to one transaction per second in order to counteract brute forcing.

#### <a id="literature6"></a> 6. Interpreting Finite Automata for Sequential Data
This paper identifies key properties used to interpret automata and proposes a modified state-merging approach to learn variants of finite state automata. Interpretation of state automata is not feature inherent in the models or the algorithm, but is defined in the need and intention of the user. Interpretations draw from the set of properties: graphical representation, transparent computation, generative nature and the human understanding of automata theory. Machine learning serves as a tool for exploration to deal with epistemic uncertainty in observed systems. The goal is not only to obtain a more compact view, but also to learn how to generalize from the observed data. A new algorithm for flexible state merging is introduced that separates the symbolic representation from the objective function and heuristic, which helps stating the parameters.

####  <a id="literature7"></a> 7. Model learning
