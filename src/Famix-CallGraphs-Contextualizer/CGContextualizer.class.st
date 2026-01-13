"
I contextualize a static call graph (`FamixCallGraph`) using dynamic execution traces (`FamixCallStack`).

## Key Messages

- `apply: aFamixCallStack on: aFamixCallGraph` : Main entry point. Projects the given stack onto the graph.

## Example
```
CGContextualizer new 
    apply: myStack 
    on: myGraph
```
"
Class {
	#name : 'CGContextualizer',
	#superclass : 'Object',
	#category : 'Famix-CallGraphs-Contextualizer',
	#package : 'Famix-CallGraphs-Contextualizer'
}

{ #category : 'as yet unclassified' }
CGContextualizer class >> apply: aCSModel on: aGraph [

	^ CGStrictContextualizer new apply: aCSModel on: aGraph
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

{ #category : 'as yet unclassified' }
CGContextualizer >> findNodeFor: targetMethod from: currentNode in: aGraph [

	self subclassResponsibility
]

{ #category : 'formatting' }
CGContextualizer >> formatTracedNodes: tracedNodes [

	^ tracedNodes collect: [ :each |
			  each -> {
				  ('receiver' -> each additionalProperties values first stacklines first receiver).
				  ('arguments' -> each additionalProperties values first stacklines first arguments) } ]
]

{ #category : 'as yet unclassified' }
CGContextualizer >> initialNodeFor: aGraph [

	^ FamixCallGraphNode new
		addCallee: aGraph entryPoint;
		yourself
]

{ #category : 'as yet unclassified' }
CGContextualizer >> propertyName [

	^ #property
]

{ #category : 'as yet unclassified' }
CGContextualizer >> tracePath: callStackSequence in: aGraph [

	| currentNode tracedNodes |
	"Stores all traced nodes"
	tracedNodes := OrderedCollection new.

	"Use this as an artificial first node to initialize algorithm"
	currentNode := self initialNodeFor: aGraph. 

	"Iterate on all stacks"
	callStackSequence do: [ :targetMethod |
			currentNode := self findNodeFor: targetMethod from: currentNode in: aGraph.

			"If nil then its not possible to continue"
			currentNode ifNil: [ ^ tracedNodes ].

			"If not nil then enrich the graph and continue"
			currentNode additionalPropertiesNamed: self propertyName put: targetMethod.
			tracedNodes add: currentNode ].

	^ tracedNodes
]
