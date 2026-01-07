"
A CGContextualizerTest is a test class for testing the behavior of CGContextualizer
"
Class {
	#name : 'CGContextualizerExample1Test',
	#superclass : 'FamixAbstractJavaCallGraphContextualizerBuilderTestCase',
	#category : 'Famix-CallGraphs-Contextualizer-Tests',
	#package : 'Famix-CallGraphs-Contextualizer-Tests'
}

{ #category : 'tests' }
CGContextualizerExample1Test >> testApplyOn [

	| tracedNodes methodsName |
	tracedNodes := CGContextualizer apply: self callStackModel on: self graph.

	methodsName := tracedNodes collect: [ :each | each key realMethod mooseName ].

	self assert: tracedNodes size equals: 3.

	self assert: methodsName first equals: 'example1.A1.main(String[])'.
	self assert: methodsName second equals: 'example1.B1.method(String[])'.
	self assert: methodsName third equals: 'java.lang.Runtime.exec(String)'
]

{ #category : 'tests' }
CGContextualizerExample1Test >> testBuildingAndApplying [

	| tracedNodes methodsName contextualizer |
	contextualizer := CGContextualizer new
		mainModel: self javaMainModel;
		entryPoint: self sourceResource entryPoints first;
		generateGraph.

	tracedNodes := contextualizer apply: self callStackModel.

	methodsName := tracedNodes collect: [ :each | each key realMethod mooseName ].

	self assert: tracedNodes size equals: 3.

	self assert: methodsName first equals: 'example1.A1.main(String[])'.
	self assert: methodsName second equals: 'example1.B1.method(String[])'.
	self assert: methodsName third equals: 'java.lang.Runtime.exec(String)'
]

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
CGContextualizerExample1Test >> testgenerateGraphOfWithDependeciesStartingForm [

	| tracedNodes methodsName contextualizer |
	contextualizer := CGContextualizer
		                  generateGraphOf: self javaMainModel
		                  withDependecies: {  }
		                  startingForm: self sourceResource entryPoints first.

	tracedNodes := contextualizer apply: self callStackModel.

	methodsName := tracedNodes collect: [ :each | each key realMethod mooseName ].

	self assert: tracedNodes size equals: 3.

	self assert: methodsName first equals: 'example1.A1.main(String[])'.
	self assert: methodsName second equals: 'example1.B1.method(String[])'.
	self assert: methodsName third equals: 'java.lang.Runtime.exec(String)'
]
