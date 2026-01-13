Extension { #name : 'FamixCallGraph' }

{ #category : '*Famix-CallGraphs-Contextualizer' }
FamixCallGraph >> allNodesWithAdditionalProperties [
	"Actually returns a Dictionary of every nodes with additionnal properties"

	^ (self allNodes collect: [ :each | each -> each additionalProperties ] thenReject: [ :each | each value isNil ])
		  asDictionary
]
