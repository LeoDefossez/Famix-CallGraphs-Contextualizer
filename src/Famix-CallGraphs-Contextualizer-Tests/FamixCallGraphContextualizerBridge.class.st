Class {
	#name : 'FamixCallGraphContextualizerBridge',
	#superclass : 'GitBridge',
	#category : 'Famix-CallGraphs-Contextualizer-Tests',
	#package : 'Famix-CallGraphs-Contextualizer-Tests'
}

{ #category : 'accessing' }
FamixCallGraphContextualizerBridge class >> resources [

	^ self root / 'resources'
]

{ #category : 'accessing' }
FamixCallGraphContextualizerBridge class >> sources [

	^ self resources / 'sources'
]
