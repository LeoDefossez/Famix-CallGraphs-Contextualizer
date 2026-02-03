Class {
	#name : 'CGContextualizerExample4Test',
	#superclass : 'FamixAbstractJavaCGContextualizerBuilderTestCase',
	#category : 'Famix-CallGraphs-Contextualizer-Tests-Tests',
	#package : 'Famix-CallGraphs-Contextualizer-Tests',
	#tag : 'Tests'
}

{ #category : 'tests' }
CGContextualizerExample4Test >> testCollectStackMethodsFrom [

	| methods |
	methods := CGContextualizer new collectCallStackMethodsFrom: self callStackModel.
	
	self assert: methods size equals: 4.
	
	
	self assert: methods first mooseName equals: 'example4.A4.main(String[])'.
	self assert: methods second mooseName equals: 'example4External.B4.toString()'.
	self assert: methods third mooseName equals: 'example4.A4.toString()'.
	self assert: methods fourth mooseName equals: 'java.lang.Runtime.exec(String)'
	
	
]

{ #category : 'tests' }
CGContextualizerExample4Test >> testInferedBuildGraph [
	"This method is here to ensure the graph building works"

	| nodes methodsName |
	nodes := self inferedContextualizer buildGraph graph
		         findPathFromNodeNamed: 'example4.A4.main(String[])'
		         toNodeNamed: 'java.lang.Runtime.exec(String)'.

	methodsName := nodes collect: [ :each | each realMethod mooseName ].

	self assert: methodsName size equals: 4.

	self assert: methodsName first equals: 'example4.A4.main(String[])'.
	self assert: methodsName second equals: 'example4External.B4.toString()'.
	self assert: methodsName third equals: 'example4.A4.toString()'.
	self assert: methodsName fourth equals: 'java.lang.Runtime.exec(String)'
]

{ #category : 'tests' }
CGContextualizerExample4Test >> testInferedRun [

	| tracedNodes methodsName |
	tracedNodes := self inferedContextualizer run first.

	methodsName := tracedNodes collect: [ :each | each key realMethod mooseName ].

	self assert: methodsName size equals: 4.

	self assert: methodsName first equals: 'example4.A4.main(String[])'.
	self assert: methodsName second equals: 'example4External.B4.toString()'.
	self assert: methodsName third equals: 'example4.A4.toString()'.
	self assert: methodsName fourth equals: 'java.lang.Runtime.exec(String)'
]

{ #category : 'tests' }
CGContextualizerExample4Test >> testStrictBuildGraph [
	"This method is here to ensure the graph building works"

	| nodes methodsName |
	nodes := self strictContextualizer buildGraph graph
		          findPathFromNodeNamed: 'example4.A4.main(String[])'
		         toNodeNamed: 'java.lang.Runtime.exec(String)'.

	methodsName := nodes collect: [ :each | each realMethod mooseName ].

	self assert: methodsName size equals: 4.

	self assert: methodsName first equals: 'example4.A4.main(String[])'.
	self assert: methodsName second equals: 'example4External.B4.toString()'.
	self assert: methodsName third equals: 'example4.A4.toString()'.
	self assert: methodsName fourth equals: 'java.lang.Runtime.exec(String)'
]

{ #category : 'tests' }
CGContextualizerExample4Test >> testStrictRun [

	| tracedNodes methodsName |
	"Here the result is not the same as the stack because we do not have access to the external dependencies on the graph"
	tracedNodes := self strictContextualizer run first.

	methodsName := tracedNodes collect: [ :each | each key realMethod mooseName ].

	self assert: methodsName size equals: 4.

	self assert: methodsName first equals: 'example4.A4.main(String[])'.
	self assert: methodsName second equals: 'example4External.B4.toString()'.
	self assert: methodsName third equals: 'example4.A4.toString()'.
	self assert: methodsName fourth equals: 'java.lang.Runtime.exec(String)'
]
