Class {
	#name : 'CGContextualizerExample2Test',
	#superclass : 'FamixAbstractJavaCGContextualizerBuilderTestCase',
	#category : 'Famix-CallGraphs-Contextualizer-Tests-Tests',
	#package : 'Famix-CallGraphs-Contextualizer-Tests',
	#tag : 'Tests'
}

{ #category : 'tests' }
CGContextualizerExample2Test >> testCollectStackMethodsFrom [

	| methods |
	methods := CGContextualizer new collectCallStackMethodsFrom: self callStackModel.
	
	self assert: methods size equals: 4.
	
	
	self assert: methods first mooseName equals: 'example2.A2.main(String[])'.
	self assert: methods second mooseName equals: 'example2External.B2.method(Object)'.
	self assert: methods third mooseName equals: 'example2.A2.toString()'.
	self assert: methods fourth mooseName equals: 'java.lang.Runtime.exec(String)'
	
	
]

{ #category : 'tests' }
CGContextualizerExample2Test >> testInferedBuildGraph [
	"This method is here to ensure the graph building works"

	| nodes methodsName |
	nodes := self inferedContextualizer buildGraph graph
		         findPathFromNodeNamed: 'example2.A2.main(String[])'
		         toNodeNamed: 'java.lang.Runtime.exec(String)'.

	methodsName := nodes collect: [ :each | each realMethod mooseName ].

	self assert: methodsName size equals: 4.

	self assert: methodsName first equals: 'example2.A2.main(String[])'.
	self assert: methodsName second equals: 'example2External.B2.method(Object)'.
	self assert: methodsName third equals: 'example2.A2.toString()'.
	self assert: methodsName fourth equals: 'java.lang.Runtime.exec(String)'
]

{ #category : 'tests' }
CGContextualizerExample2Test >> testInferedRun [

	| tracedNodes methodsName |
	"Here the result should be the same as the stack because we create the nodes that aren't present"
	tracedNodes := self inferedContextualizer run first.

	methodsName := tracedNodes collect: [ :each | each key realMethod mooseName ].

	self assert: tracedNodes size equals: 4.

	self assert: methodsName first equals: 'example2.A2.main(String[])'.
	self assert: methodsName second equals: 'example2External.B2.method(Object)'.
	self assert: methodsName third equals: 'example2.A2.toString()'.
	self assert: methodsName fourth equals: 'java.lang.Runtime.exec(String)'
]

{ #category : 'tests' }
CGContextualizerExample2Test >> testStrictBuildGraph [
	"This method is here to ensure the graph building works"

	"There should be no path, so an error is thrown"

	self
		should: [
				self strictContextualizer buildGraph graph
					findPathFromNodeNamed: 'example2.A2.main(String[])'
					toNodeNamed: 'java.lang.Runtime.exec(String)' ]
		raise: Error
]

{ #category : 'tests' }
CGContextualizerExample2Test >> testStrictRun [

	| tracedNodes methodsName |
	"Here the result is not the same as the stack because we do not have access to the external dependencies on the graph"
	tracedNodes := self strictContextualizer run first.

	methodsName := tracedNodes collect: [ :each | each key realMethod mooseName ].

	self assert: tracedNodes size equals: 2.

	self assert: methodsName first equals: 'example2.A2.main(String[])'.
	self assert: methodsName second equals: 'example2External.B2.method(Object)'
]
