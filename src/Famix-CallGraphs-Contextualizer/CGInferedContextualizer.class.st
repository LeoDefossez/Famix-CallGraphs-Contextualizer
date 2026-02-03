Class {
	#name : 'CGInferedContextualizer',
	#superclass : 'CGContextualizer',
	#category : 'Famix-CallGraphs-Contextualizer',
	#package : 'Famix-CallGraphs-Contextualizer'
}

{ #category : 'as yet unclassified' }
CGInferedContextualizer >> createReflectivesHookOn: aGraphBuilder withWorkspace: workspace [

	| stacklines modelMethods modelMethodNames matches |
	stacklines := callStackModels flatCollect: [ :each | each allWithType: FamixCSStackline ].
	modelMethods := { mainModel } , librariesModels flatCollect: [ :each | each allMethods ].
	modelMethodNames := modelMethods collect: #mooseName.


	aGraphBuilder reflectiveHook: [ :node :builder |
			workspace interModelModeDuring: [
					(modelMethodNames includes: node realMethod mooseName)
						ifTrue: [ "if true then add path to stacklines"
								matches := stacklines select: [ :each | each method mooseName = node realMethod mooseName ].
								matches := matches collect: [ :each | each next ifNotNil: [ :next | next method ] ].
								matches := matches reject: [ :each | each isNil or: [ modelMethodNames includes: each mooseName ] ].
								matches := matches do: [ :each |
										           self flag: #todo. "We say the node is not a stub so that the graphs continue to create after this node, but is is a bit false, because it is in fact a stub"
										           node addCallee: (builder nodeForMethodSignature: each signature kind: each parentType stub: false) ] ]
						ifFalse: [ 1 halt "if false then reconstruct the path from the stackline to the graph" ] ] ]
]
