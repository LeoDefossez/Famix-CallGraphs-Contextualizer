Class {
	#name : 'CGInferedContextualizer',
	#superclass : 'CGContextualizer',
	#category : 'Famix-CallGraphs-Contextualizer',
	#package : 'Famix-CallGraphs-Contextualizer'
}

{ #category : 'as yet unclassified' }
CGInferedContextualizer >> createReflectivesHookOn: aGraphBuilder [

	| stacklines modelMethods matches |
	stacklines := callStackModels flatCollect: [ :each | each allWithType: FamixCSStackline ].
	modelMethods := { mainModel } , librariesModels flatCollect: [ :each | each allMethods ].

	aGraphBuilder reflectiveHook: [ :node :builder |
			matches := stacklines select: [ :each | each method mooseName = node realMethod mooseName ].

			matches
				reject: [ :each | (modelMethods collect: [ :method | method mooseName ]) includes: each next method mooseName ]
				thenDo: [ :each |
					node addCallee: (builder nodeForMethodSignature: each method signature kind: each method parentType stub: false) ] ]
]
