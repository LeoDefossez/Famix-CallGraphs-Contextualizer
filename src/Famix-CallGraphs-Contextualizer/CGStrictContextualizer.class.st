Class {
	#name : 'CGStrictContextualizer',
	#superclass : 'CGContextualizer',
	#category : 'Famix-CallGraphs-Contextualizer',
	#package : 'Famix-CallGraphs-Contextualizer'
}

{ #category : 'as yet unclassified' }
CGStrictContextualizer >> findNodeFor: targetMethod from: currentNode in: aGraph [

	^ currentNode callees detect: [ :each | each realMethod mooseName = targetMethod mooseName ] ifNone: [ nil ]
]
