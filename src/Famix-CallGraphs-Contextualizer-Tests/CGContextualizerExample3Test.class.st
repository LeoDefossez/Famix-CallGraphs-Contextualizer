Class {
	#name : 'CGContextualizerExample3Test',
	#superclass : 'FamixAbstractJavaCGContextualizerBuilderTestCase',
	#category : 'Famix-CallGraphs-Contextualizer-Tests-Tests',
	#package : 'Famix-CallGraphs-Contextualizer-Tests',
	#tag : 'Tests'
}

{ #category : 'tests' }
CGContextualizerExample3Test >> testCollectStackMethodsFrom [

	| methods |
	methods := CGContextualizer new collectCallStackMethodsFrom: self callStackModel.
	
	self assert: methods size equals: 4.
	
	
	self assert: methods first mooseName equals: 'example3.A3.main(String[])'.
	self assert: methods second mooseName equals: 'example3External.B3.method(Object)'.
	self assert: methods third mooseName equals: 'example3.A3.toString()'.
	self assert: methods fourth mooseName equals: 'java.lang.Runtime.exec(String)'
	
	
]

{ #category : 'tests' }
CGContextualizerExample3Test >> testInferedBuildGraph [
	"This method is here to ensure the graph building works"

	| nodes methodsName |
	nodes := self inferedContextualizer buildGraph graph
		         findPathFromNodeNamed: 'example3.A3.main(String[])'
		         toNodeNamed: 'java.lang.Runtime.exec(String)'.

	methodsName := nodes collect: [ :each | each realMethod mooseName ].

	self assert: methodsName size equals: 4.

	self assert: methodsName first equals: 'example3.A3.main(String[])'.
	self assert: methodsName second equals: 'example3External.B3.method(Object)'.
	self assert: methodsName third equals: 'example3.A3.toString()'.
	self assert: methodsName fourth equals: 'java.lang.Runtime.exec(String)'
]

{ #category : 'tests' }
CGContextualizerExample3Test >> testInferedRun [

	| tracedNodes methodsName |
	tracedNodes := self inferedContextualizer run first.

	methodsName := tracedNodes collect: [ :each | each key realMethod mooseName ].

	self assert: tracedNodes size equals: 4.

	self assert: methodsName first equals: 'example3.A3.main(String[])'.
	self assert: methodsName second equals: 'example3External.B3.method(Object)'.
	self assert: methodsName third equals: 'example3.A3.toString()'.
	self assert: methodsName fourth equals: 'java.lang.Runtime.exec(String)'
]

{ #category : 'tests' }
CGContextualizerExample3Test >> testStrictBuildGraph [
	"This method is here to ensure the graph building works"

	| nodes methodsName |
	nodes := self strictContextualizer buildGraph graph
		         findPathFromNodeNamed: 'example3.A3.main(String[])'
		         toNodeNamed: 'java.lang.Runtime.exec(String)'.

	methodsName := nodes collect: [ :each | each realMethod mooseName ].

	self assert: methodsName size equals: 4.

	self assert: methodsName first equals: 'example3.A3.main(String[])'.
	self assert: methodsName second equals: 'example3External.B3.method(Object)'.
	self assert: methodsName third equals: 'example3.A3.toString()'.
	self assert: methodsName fourth equals: 'java.lang.Runtime.exec(String)'
]

{ #category : 'tests' }
CGContextualizerExample3Test >> testStrictRun [

	| tracedNodes methodsName |
	self skip. "Skipped because the problem seems to come from FamixBridge"
	self flag:#todo. "correct this test case"
	tracedNodes := self strictContextualizer run first.
	self halt.
	methodsName := tracedNodes collect: [ :each | each key realMethod mooseName ].

	self assert: tracedNodes size equals: 4.

	self assert: methodsName first equals: 'example3.A3.main(String[])'.
	self assert: methodsName second equals: 'example3External.B3.method(Object)'.
	self assert: methodsName third equals: 'example3.A3.toString()'.
	self assert: methodsName fourth equals: 'java.lang.Runtime.exec(String)'
]
