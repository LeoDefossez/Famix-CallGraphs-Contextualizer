"
I bridge the gap between static analysis (FamixCallGraph) and dynamic analysis (FamixCallStack). 
My responsibility is to contextualize a static call graph by applying execution traces (call stacks) onto it.

I operate in two distinct modes:

1. **Graph Generator & Contextualizer:**
   I build the graph from source models, then apply call stacks to filter/enrich it.
   
2. **Contextualizer:**
	I apply a call stack directly to an existing graph instance.

## Examples

### 1. Full Creation Mode (Builder)
	This mode is useful when you start from raw Famix models.

```smalltalk
contextualizer := CGContextualizer new
    mainModel: model1;
    addLibraryModel: model2;
    entryPoint: aFamixMethod;
    generateGraph.

""Apply dynamic context""
contextualizer
    apply: csModel1;
    apply: csModel2.

""Access results""
contextualizer graph.
contextualizer allContextualizedNodes.
```

### 2. Application Mode (Utility)
Use this if you already have a calculated graph and want to filter it with a stack.
```smalltalk
	CGContextualizer 
		apply: aCSModel 
		on: aGraph.
```
"
Class {
	#name : 'CGContextualizer',
	#superclass : 'Object',
	#instVars : [
		'workspace',
		'entryPoint',
		'graph'
	],
	#category : 'Famix-CallGraphs-Contextualizer',
	#package : 'Famix-CallGraphs-Contextualizer'
}

{ #category : 'as yet unclassified' }
CGContextualizer class >> apply: aCSModel on: aGraph [

	^ self new apply: aCSModel on: aGraph
]

{ #category : 'as yet unclassified' }
CGContextualizer class >> generateGraphOf: mainModel withDependecies: libraryModels startingForm: entryPoint [

	| contextualizer |
	contextualizer := self new
		                  mainModel: mainModel;
		                  addLibraryModels: libraryModels;
		                  entryPoint: entryPoint;
		                  generateGraph.
	^ contextualizer
]

{ #category : 'as yet unclassified' }
CGContextualizer >> addLibraryModel: aMooseModel [

	self workspace addLibraryModel: aMooseModel
]

{ #category : 'as yet unclassified' }
CGContextualizer >> addLibraryModels: aCollection [

	aCollection do: [ :each | self workspace addLibraryModel: each ]
]

{ #category : 'as yet unclassified' }
CGContextualizer >> allContextualizedNodes [
	"Actually returns a Dictionary of every nodes with additionnal properties"

	^ (graph allNodes collect: [ :each | each -> each additionalProperties ] thenReject: [ :each | each value isNil ])
		  asDictionary
]

{ #category : 'as yet unclassified' }
CGContextualizer >> apply: aFamixCSModel [

	^ self apply: aFamixCSModel on: graph
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
CGContextualizer >> entryPoint [
	^ entryPoint
]

{ #category : 'as yet unclassified' }
CGContextualizer >> entryPoint: aFamixMethod [

	entryPoint := aFamixMethod
]

{ #category : 'formatting' }
CGContextualizer >> formatTracedNodes: tracedNodes [

	^ tracedNodes collect: [ :each |
			  each -> {
				  ('receiver' -> each additionalProperties values first stacklines first receiver).
				  ('arguments' -> each additionalProperties values first stacklines first arguments) } ]
]

{ #category : 'as yet unclassified' }
CGContextualizer >> generateGraph [

	self workspace interModelModeDuring: [ graph := (FamixJavaCHABuilder entryPoint: self entryPoint) build ]
]

{ #category : 'as yet unclassified' }
CGContextualizer >> graph [

	^ graph
]

{ #category : 'as yet unclassified' }
CGContextualizer >> mainModel: aFamixJavaModel [

	self workspace mainModel: aFamixJavaModel
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
				detect: [ :each |  each realMethod mooseName = targetMethod mooseName ]
				ifFound: [ :each |
						each additionalPropertiesNamed: self propertyName put: targetMethod.
						tracedNodes add: each.
						next := each ]
				ifNone: [ "If not found stop the search here" ^ tracedNodes ] ].

	^ tracedNodes
]

{ #category : 'as yet unclassified' }
CGContextualizer >> workspace [

	^ workspace ifNil: [ workspace := MooseWorkspace new ]
]
