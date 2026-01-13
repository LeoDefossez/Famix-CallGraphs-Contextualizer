"
I contextualize a static call graph (`FamixCallGraph`) using dynamic execution traces (`FamixCallStack`).

## Example
```
""returns all path of enriched nodes""
aContextualizerClass new
		  mainModel: mainModel;
		  librariesModels: librariesModels;
		  entryPoints: { aFamixMethod };
		  callStackModels: { callStackModel };
		  run
```
"
Class {
	#name : 'CGContextualizer',
	#superclass : 'Object',
	#instVars : [
		'mainModel',
		'librariesModels',
		'callStackModels',
		'graph',
		'entryPoints',
		'graphBuilder'
	],
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
CGContextualizer >> buildGraph [

	| workspace |
	workspace := MooseWorkspace new mainModel: mainModel.
	librariesModels do: [ :each | workspace addLibraryModel: each ].
	
	self createReflectivesHookOn: graphBuilder.

	graph := workspace interModelModeDuring: [
			         graphBuilder
				         entryPoints: entryPoints;
				         build ]
]

{ #category : 'settings' }
CGContextualizer >> callStackModels: aCollection [

	callStackModels := aCollection
]

{ #category : 'as yet unclassified' }
CGContextualizer >> collectCallStackMethodsFrom: aCSModel [
	"stacklines should be ordered by default"

	^ (aCSModel allWithType: FamixCSStack) anyOne stacklines collect: [ :each | each method ]
]

{ #category : 'as yet unclassified' }
CGContextualizer >> createReflectivesHookOn: aGraphBuilder [

	self subclassResponsibility
]

{ #category : 'settings' }
CGContextualizer >> entryPoints: aCollection [

	entryPoints := aCollection
]

{ #category : 'as yet unclassified' }
CGContextualizer >> findNodeFor: targetMethod from: currentNode in: aGraph [

	^ currentNode callees detect: [ :each | each realMethod mooseName = targetMethod mooseName ] ifNone: [ nil ]
]

{ #category : 'formatting' }
CGContextualizer >> formatTracedNodes: tracedNodes [

	^ tracedNodes collect: [ :each |
			  each -> {
				  ('receiver' -> each additionalProperties values first stacklines first receiver).
				  ('arguments' -> each additionalProperties values first stacklines first arguments) } ]
]

{ #category : 'settings' }
CGContextualizer >> graph [
	
	^ graph
]

{ #category : 'as yet unclassified' }
CGContextualizer >> graphBuilder: aGraphBuilder [

	graphBuilder := aGraphBuilder
]

{ #category : 'as yet unclassified' }
CGContextualizer >> initialNodeFor: aGraph [

	^ FamixCallGraphNode new
		addCallee: aGraph entryPoint;
		yourself
]

{ #category : 'as yet unclassified' }
CGContextualizer >> initialize [

	graphBuilder := FamixJavaCHABuilder new
]

{ #category : 'settings' }
CGContextualizer >> librariesModels: aCollection [

	librariesModels := aCollection asMooseGroup 
]

{ #category : 'settings' }
CGContextualizer >> mainModel: aFamixModel [

	mainModel := aFamixModel
]

{ #category : 'as yet unclassified' }
CGContextualizer >> propertyName [

	^ #property
]

{ #category : 'as yet unclassified' }
CGContextualizer >> run [

	self buildGraph.
	^ callStackModels collect: [ :each | self apply: each on: graph ]
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
