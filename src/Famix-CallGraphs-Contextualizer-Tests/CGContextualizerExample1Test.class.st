"
A CGContextualizerTest is a test class for testing the behavior of CGContextualizer
"
Class {
	#name : 'CGContextualizerExample1Test',
	#superclass : 'FamixAbstractJavaCallGraphContextualizerBuilderTestCase',
	#category : 'Famix-CallGraphs-Contextualizer-Tests',
	#package : 'Famix-CallGraphs-Contextualizer-Tests'
}

{ #category : 'running' }
CGContextualizerExample1Test >> performTest [

	FamixCallGraphAdditionalProperties newInstanceDuring: [ super performTest ]
]

{ #category : 'tests' }
CGContextualizerExample1Test >> testApplyOn [

	| tracedNodes methodsName |
	tracedNodes := CGContextualizer apply: self callStackModel on: self graph.

	methodsName := tracedNodes collect: [ :each | each key realMethod mooseName ].

	self assert: tracedNodes size equals: 3.

	self assert: methodsName first equals: '<Default Package>.A.main(String[])'.
	self assert: methodsName second equals: '<Default Package>.B.method(String[])'.
	self assert: methodsName third equals: 'java.lang.Runtime.exec(String)'
]

{ #category : 'tests' }
CGContextualizerExample1Test >> testCollectStackMethodsFrom [

	| methods |
	methods := CGContextualizer new collectCallStackMethodsFrom: self callStackModel.
	
	self assert: methods size equals: 3.
	
	self assert: methods first mooseName equals: '<Default Package>.A.main(String[])'.
	self assert: methods second mooseName equals: '<Default Package>.B.method(String[])'.
	self assert: methods third mooseName equals: 'java.lang.Runtime.exec(String)'
	
]
