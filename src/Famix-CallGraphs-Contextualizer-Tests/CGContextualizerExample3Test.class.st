Class {
	#name : 'CGContextualizerExample3Test',
	#superclass : 'FamixAbstractJavaCallGraphContextualizerBuilderTestCase',
	#category : 'Famix-CallGraphs-Contextualizer-Tests',
	#package : 'Famix-CallGraphs-Contextualizer-Tests'
}

{ #category : 'tests' }
CGContextualizerExample3Test >> testApplyOn [

	| tracedNodes methodsName |
	self skip. "Skipped because the problem seems to come from FamixBridge"
	self flag:#todo. "correct this test case"
	tracedNodes := CGContextualizer apply: self callStackModel on: self graph.

	methodsName := tracedNodes collect: [ :each | each key realMethod mooseName ].

	self assert: tracedNodes size equals: 4.

	self assert: methodsName first equals: 'example3.A3.main(String[])'.
	self assert: methodsName second equals: 'example3External.B3.method(Object)'.
	self assert: methodsName third equals: 'example3.A3.toString()'.
	self assert: methodsName fourth equals: 'java.lang.Runtime.exec(String)'
]

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
