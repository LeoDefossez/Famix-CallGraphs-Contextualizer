Class {
	#name : 'CGInferedContextualizer',
	#superclass : 'CGContextualizer',
	#category : 'Famix-CallGraphs-Contextualizer',
	#package : 'Famix-CallGraphs-Contextualizer'
}

{ #category : 'as yet unclassified' }
CGInferedContextualizer >> createReflectivesHookOn: aGraphBuilder withWorkspace: workspace [

	| stacklines modelMethodNames |
	stacklines := callStackModels flatCollect: [ :each | each allWithType: FamixCSStackline ].

	"Convert to Set to ensure O(1) lookup performance inside the reflective hook"
	modelMethodNames := ({ mainModel } , librariesModels flatCollect: [ :each | each allMethods ])
		                    collect: #mooseName
		                    as: Set.

	aGraphBuilder reflectiveHook: [ :node :builder |
			workspace interModelModeDuring: [
					| currentMooseName nextDynamicMethods |
					currentMooseName := node realMethod mooseName.

					"Extract the methods from the execution trace"
					nextDynamicMethods := (stacklines
						                       select: [ :stackline | stackline method mooseName = currentMooseName ]
						                       thenCollect: [ :stackline | stackline next ifNotNil: #method ]) reject: #isNil.

					(modelMethodNames includes: currentMooseName)
						ifTrue: [ "In-model node: Filter out trace methods that are already resolved by static analysis"
							nextDynamicMethods := nextDynamicMethods reject: [ :m | modelMethodNames includes: m mooseName ] ]
						ifFalse: [ "Out-of-model node: Retain all methods to reconnect the dynamic trace to the main graph" ].

					"Construct graph edges for the identified dynamic callees."
					nextDynamicMethods do: [ :eachMethod | "Stub is forced to false to guarantee continuous graph expansion"
						node addCallee: (builder nodeForMethodSignature: eachMethod signature kind: eachMethod parentType stub: false) ] ] ]
]
