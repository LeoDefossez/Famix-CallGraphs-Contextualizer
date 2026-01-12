Class {
	#name : 'FamixCallGraphContextualizerBridge',
	#superclass : 'GitBridge',
	#category : 'Famix-CallGraphs-Contextualizer-Tests-Resources',
	#package : 'Famix-CallGraphs-Contextualizer-Tests',
	#tag : 'Resources'
}

{ #category : 'accessing' }
FamixCallGraphContextualizerBridge class >> resources [

	^ self root / 'resources'
]

{ #category : 'accessing' }
FamixCallGraphContextualizerBridge class >> sources [

	^ self resources / 'sources' / 'contextualizer'
]
