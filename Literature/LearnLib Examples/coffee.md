## Coffee example

Accompanied by http://www.falkhowar.de/papers/SFM2011-Introduction-to-Active-Automata-Learning-from-a-Practical-Perspective.pdf


Uses CompactMealy: AutomataLib's own internal data structure for explicit-state, explicit-alphabet Mealy machines.
Automata learning algorithms do not interact with the target system directly, but via a (membership) oracle. In our case, the membership oracle simply simulates traces on the automaton, we therefore use a SimulatorOracle.
Additionally, we want to count the number of queries that actually reach the target system (SUL, System Under Learning). In LearnLib, this is realized by encapsulating the (target) oracle in another oracle, which takes care of the counting. This allows the user to declare a pipeline of several  so-called filters.
A cache speeds up the process. A cache is created with the encapsulating query-counter oracle and the input alphabet.

The query counter oracle takes care of counting how many queries reach the target system. Note that since the cache was added to the pipeline *after* the first counter oracle, some queries will be filtered by the cache and not reach the counter oracle (and thus the target system). Therefore, we add a second counter oracle, this time on top of the cache, to count the queries sent from the learner (pre-caching).
Create the learning algorithm. Here, we use LearnLib's preferred variant of the L* algorithm for Mealy machines. All learning algorithms require specifying an oracle and a learning alphabet. On top of that, some algorithms are configurable via various other parameters, but these are all optional.
Start the learning process, until it converges to a first stable hypothesis. Further progress after this initial step is only triggered by counterexamples.

Create an equivalence oracle, for generating counterexamples. Here, we use a random words (or random sampling) oracle, that approximates equivalence queries by randomly generating words of length uniformly distributed between 5 and 20. If it does not find a counterexample after 1000 steps, it stops.
A cache can also be used to implement a form of equivalence oracle, namely by testing the result of every query stored in the cache against the current hypothesis. Such a **cache consistency test** can be obtained directly from the cache oracle.
Both Equivalency-oracles can be combined together.
Counterexamples in LearnLib are stored in the form of a query. A query consists of an input word (separated into prefix and suffix), and can be answered. The DefaultQuery class stores the answer, and makes it available via getOutput().

```java
CompactMealy<Input,String> target = ExampleCoffeeMachine.constructMachine();
Alphabet<Input> alphabet = target.getInputAlphabet();
Visualization.visualizeGraph(target.graphView(), true);
MembershipOracle.MealyMembershipOracle<Input, String> oracle = new SimulatorOracle.MealySimulatorOracle<>(target);
MealyCounterOracle<Input, String> queryCounter = new MealyCounterOracle<>(oracle, "Queries to SUL");
MealyCacheOracle<Input, String> cache = MealyCaches.createCache(alphabet, queryCounter);
MealyCounterOracle<Input, String> learnerQueryCounter = new MealyCounterOracle<>(cache, "Queries from Learner");
MembershipOracle.MealyMembershipOracle<Input, String> effOracle	= learnerQueryCounter;
ExtensibleLStarMealy<Input, String> learner
			= new ExtensibleLStarMealyBuilder<Input,String>()
				.withAlphabet(alphabet)
				.withOracle(effOracle)
				// An example for an optional parameter is the counterexample handler.
				// By default, L* adds all prefixes of a counterexample to the observation
				// table, but other variants are generally much more efficient.
				// Uncomment the following line to see the effect of replacing a counterexample
				// handler.
//				.withCexHandler(ObservationTableCEXHandlers.RIVEST_SCHAPIRE)
				.create();

learner.startLearning();

EquivalenceOracle.MealyEquivalenceOracle<Input, String> randomEqOracle
  = new RandomWordsEQOracle.MealyRandomWordsEQOracle<>(
      oracle, // the target oracle
      5,      // the minimum sample length
      20,     // the maximum sample length
      1000,   // the maximum number of tests in one iteration
      new Random());

EquivalenceOracle.MealyEquivalenceOracle<Input, String> consistencyEqOracle = cache.createCacheConsistencyTest();
EquivalenceOracle.MealyEquivalenceOracle<Input, String> eqOracle = new EQOracleChain.MealyEQOracleChain<>(consistencyEqOracle, randomEqOracle);
DefaultQuery<Input, Word<String>> ce;
while ((ce = eqOracle.findCounterExample(learner.getHypothesisModel(),alphabet)) != null)
    learner.refineHypothesis(ce);
OTUtils.displayHTMLInBrowser(learner.getObservationTable());
Visualization.visualizeAutomaton(learner.getHypothesisModel(), alphabet, true);
```
