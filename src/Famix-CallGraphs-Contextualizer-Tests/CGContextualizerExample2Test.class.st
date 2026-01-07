Class {
	#name : 'CGContextualizerExample2Test',
	#superclass : 'FamixAbstractJavaCallGraphContextualizerBuilderTestCase',
	#category : 'Famix-CallGraphs-Contextualizer-Tests',
	#package : 'Famix-CallGraphs-Contextualizer-Tests'
}

{ #category : 'tests' }
CGContextualizerExample2Test >> testApplyOn [

	| tracedNodes methodsName |
	"Here the result is not the same as the stack because we do not have access to the external dependencies on the graph"
	tracedNodes := CGContextualizer apply: self callStackModel on: self graph.

	methodsName := tracedNodes collect: [ :each | each key realMethod mooseName ].

	self assert: tracedNodes size equals: 1.

	self assert: methodsName first equals: 'example2.A2.main(String[])'.
]

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
