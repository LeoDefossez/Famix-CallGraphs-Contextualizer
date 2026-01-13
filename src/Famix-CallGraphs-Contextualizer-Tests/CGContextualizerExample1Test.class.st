"
A CGContextualizerTest is a test class for testing the behavior of CGContextualizer
"
Class {
	#name : 'CGContextualizerExample1Test',
	#superclass : 'FamixAbstractJavaCGContextualizerBuilderTestCase',
	#category : 'Famix-CallGraphs-Contextualizer-Tests-Tests',
	#package : 'Famix-CallGraphs-Contextualizer-Tests',
	#tag : 'Tests'
}

{ #category : 'tests' }
CGContextualizerExample1Test >> testCollectStackMethodsFrom [

	| methods |
	methods := CGContextualizer new collectCallStackMethodsFrom: self callStackModel.
	
	self assert: methods size equals: 3.
	
	self assert: methods first mooseName equals: 'example1.A1.main(String[])'.
	self assert: methods second mooseName equals: 'example1.B1.method(String[])'.
	self assert: methods third mooseName equals: 'java.lang.Runtime.exec(String)'
	
]

{ #category : 'tests' }
CGContextualizerExample1Test >> testInferedBuildGraph [
	"This method is here to ensure the graph building works"

	| nodes methodsName |
	nodes := self inferedContextualizer buildGraph graph
		               findPathFromNodeNamed: 'example1.A1.main(String[])'
		               toNodeNamed: 'java.lang.Runtime.exec(String)'.

	methodsName := nodes collect: [ :each | each realMethod mooseName ].

	self assert: nodes size equals: 3.

	self assert: methodsName first equals: 'example1.A1.main(String[])'.
	self assert: methodsName second equals: 'example1.B1.method(String[])'.
	self assert: methodsName third equals: 'java.lang.Runtime.exec(String)'
]

{ #category : 'tests' }
CGContextualizerExample1Test >> testInferedRun [

	| tracedNodes methodsName |
	tracedNodes := self inferedContextualizer run first.

	methodsName := tracedNodes collect: [ :each | each key realMethod mooseName ].

	self assert: tracedNodes size equals: 3.

	self assert: methodsName first equals: 'example1.A1.main(String[])'.
	self assert: methodsName second equals: 'example1.B1.method(String[])'.
	self assert: methodsName third equals: 'java.lang.Runtime.exec(String)'
]

{ #category : 'tests' }
CGContextualizerExample1Test >> testStrictBuildGraph [
	"This method is here to ensure the graph building works"

	| nodes methodsName |
	nodes := self strictContextualizer buildGraph graph
		               findPathFromNodeNamed: 'example1.A1.main(String[])'
		               toNodeNamed: 'java.lang.Runtime.exec(String)'.

	methodsName := nodes collect: [ :each | each realMethod mooseName ].

	self assert: nodes size equals: 3.

	self assert: methodsName first equals: 'example1.A1.main(String[])'.
	self assert: methodsName second equals: 'example1.B1.method(String[])'.
	self assert: methodsName third equals: 'java.lang.Runtime.exec(String)'
]

{ #category : 'tests' }
CGContextualizerExample1Test >> testStrictRun [

	| tracedNodes methodsName |
	tracedNodes := self strictContextualizer run first.

	methodsName := tracedNodes collect: [ :each | each key realMethod mooseName ].

	self assert: tracedNodes size equals: 3.

	self assert: methodsName first equals: 'example1.A1.main(String[])'.
	self assert: methodsName second equals: 'example1.B1.method(String[])'.
	self assert: methodsName third equals: 'java.lang.Runtime.exec(String)'
]
