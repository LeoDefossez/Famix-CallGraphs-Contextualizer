Class {
	#name : 'CGContextualizer',
	#superclass : 'Object',
	#category : 'Famix-CallGraphs-Contextualizer',
	#package : 'Famix-CallGraphs-Contextualizer'
}

{ #category : 'as yet unclassified' }
CGContextualizer class >> apply: aCSModel on: aGraph [

	^ self new apply: aCSModel on: aGraph
]

{ #category : 'as yet unclassified' }
CGContextualizer >> apply: aCSModel on: aGraph [

	| callStackSequence tracedNodes |
	
	"Collecting all methods on the stack in order of the stack"
	callStackSequence := self collectCallStackMethodsFrom: aCSModel.

	"Add additionnals properties on the graph"
	tracedNodes := self tracePath: callStackSequence in: aGraph.


	"Offer a simple view to read added informations"
	^ self formatTracedNodes: tracedNodes
]

{ #category : 'as yet unclassified' }
CGContextualizer >> collectCallStackMethodsFrom: aCSModel [
	"stacklines should be ordered by default"

	^ (aCSModel allWithType: FamixCSStack) anyOne stacklines collect: [ :each | each method ]
]

{ #category : 'formatting' }
CGContextualizer >> formatTracedNodes: tracedNodes [

	^ tracedNodes collect: [ :each |
			  each -> {
				  ('receiver' -> each additionalProperties values first stacklines first receiver).
				  ('arguments' -> each additionalProperties values first stacklines first arguments) } ]
]

{ #category : 'as yet unclassified' }
CGContextualizer >> propertyName [

	^ #property
]

{ #category : 'as yet unclassified' }
CGContextualizer >> tracePath: callStackSequence in: aGraph [

	| next tracedNodes |
	"Stores all traced nodes"
	tracedNodes := OrderedCollection new.

	"Use this as an artificial first node to initialize algorithm"
	next := FamixCallGraphNode new
		        addCallee: aGraph entryPoint;
		        yourself.
	
	"Iterate on all stacks"
	callStackSequence do: [ :targetMethod |
			next callees
				detect: [ :each | each realMethod mooseName = targetMethod mooseName ]
				ifFound: [ :each |
						each additionalPropertiesNamed: self propertyName put: targetMethod.
						tracedNodes add: each.
						next := each ]
				ifNone: [ "If not found stop the search here" ^ tracedNodes ] ].

	^ tracedNodes
]
