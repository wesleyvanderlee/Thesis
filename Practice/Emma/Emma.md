# EMMA

EMMA is an open-source toolkit for measuring and reporting Java code coverage. EMMA distinguishes itself from other tools by going after a unique feature combination: support for large-scale enterprise software development while keeping individual developer's work fast and iterative. Android includes EMMA v2.0, build 5312, which includes some minor changes introduced by Android to adapt it for the platform specifics.

## Android Instrumentation
The instrumentation framework is the foundation of the testing framework. Instrumentation controls the application under test and permits the injection of mock components required by the application to run. Usually, an InstrumentationTestRunner, a special class the extends Instrumentation, is used to run various types of TestCases, against an android application. Typically, this Instrumentation is declared in the test project's AndroidManifest.xml and then run from Eclipse or from the command line using am instrument. Also, to generate EMMA code coverage `-e coverage true` option is added to the command line. Basically, we have all the components but in different places because we want to obtain the code coverage from the running application not from its tests.

## EmmaInstrumentation
The first thing we need to do is to create a new Instrumentation that starts the Activity Under Test using EMMA instrumentation and when this Activity is finished the coverage data is saved to a file.
To be notified of this Activity finish we need a listener that we can set extending the AUT because one of our objectives is to keep it unchanged.

To illustrate this technique we will be using the Temperature Converter application that we have used many times in other posts. The source code is as usual available through github.

Useful source: http://dtmilano.blogspot.nl/2011/11/obtaining-code-coverage-of-running.html


