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
			self gitBridge: spec.
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

	spec baseline: 'FamixBridge' with: [ spec repository: 'github://moosetechnology/Famix-Bridge/src' ]
]

{ #category : 'dependencies' }
BaselineOfFamixCallGraphsContextualizer >> famixCallGraphs: spec [

	spec baseline: 'FamixCallGraphs' with: [ spec repository: 'github://jecisc/Famix-CallGraphs/src' ]
]

{ #category : 'dependencies' }
BaselineOfFamixCallGraphsContextualizer >> famixCallStacks: spec [

	spec baseline: 'FamixCallStack' with: [ spec repository: 'github://moosetechnology/FamixCallStack/src' ]
]

{ #category : 'dependencies' }
BaselineOfFamixCallGraphsContextualizer >> gitBridge: spec [

	self flag: #todo. "Already a dependency of FamixCallGraphs, should not need to import this"

	spec baseline: 'GitBridge' with: [ spec repository: 'github://jecisc/GitBridge:v1.x.x/src' ]
]
