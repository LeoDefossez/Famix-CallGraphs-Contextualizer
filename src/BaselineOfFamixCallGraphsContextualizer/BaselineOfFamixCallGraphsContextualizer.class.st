Class {
	#name : 'BaselineOfFamixCallGraphsContextualizer',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfFamixCallGraphsContextualizer',
	#package : 'BaselineOfFamixCallGraphsContextualizer'
}

{ #category : 'baselines' }
BaselineOfFamixCallGraphsContextualizer >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
			"Dependencies"
			self famixBridge: spec.
			self famixCallGraphs: spec.
			self famixCallStacks: spec.

			"Packages"
			spec
				package: 'Famix-CallGraphs-Contextualizer';
				package: 'Famix-CallGraphs-Contextualizer-Tests' with: [ spec requires: #( 'Famix-CallGraphs-Contextualizer' ) ].

			"Groups"
			spec
				group: 'Core' with: #( 'Famix-CallGraphs-Contextualizer' );
				group: 'Tests' with: #( 'Famix-CallGraphs-Contextualizer-Tests' ) ]
]

{ #category : 'dependencies' }
BaselineOfFamixCallGraphsContextualizer >> famixBridge: spec [

	spec baseline: 'FamixBridge' with: [ spec repository: 'github://moosetechnology/Famix-Bridge:main/src' ]
]

{ #category : 'dependencies' }
BaselineOfFamixCallGraphsContextualizer >> famixCallGraphs: spec [

	spec baseline: 'FamixBridge' with: [ spec repository: 'github://jecisc/Famix-CallGraphs:main/src' ]
]

{ #category : 'dependencies' }
BaselineOfFamixCallGraphsContextualizer >> famixCallStacks: spec [

	spec baseline: 'FamixCallStack' with: [ spec repository: 'github://moosetechnology/FamixCallStack:main/src' ]
]
