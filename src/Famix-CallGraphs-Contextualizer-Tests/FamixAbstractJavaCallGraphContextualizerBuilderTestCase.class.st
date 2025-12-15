Class {
	#name : 'FamixAbstractJavaCallGraphContextualizerBuilderTestCase',
	#superclass : 'TestCase',
	#category : 'Famix-CallGraphs-Contextualizer-Tests',
	#package : 'Famix-CallGraphs-Contextualizer-Tests'
}

{ #category : 'helpers' }
FamixAbstractJavaCallGraphContextualizerBuilderTestCase class >> browseSources [

	<script>
	self sourceResource javaSourcesFolder openInOSFileBrowser
]

{ #category : 'testing' }
FamixAbstractJavaCallGraphContextualizerBuilderTestCase class >> isAbstract [

	^ self = FamixAbstractJavaCallGraphContextualizerBuilderTestCase
]

{ #category : 'accessing' }
FamixAbstractJavaCallGraphContextualizerBuilderTestCase class >> resources [

	^ self environment
		  at: ((self name withoutSuffix: 'Test') , 'Resource') asSymbol
		  ifPresent: [ :class | { class } ]
		  ifAbsent: [ {  } ]
]

{ #category : 'helpers' }
FamixAbstractJavaCallGraphContextualizerBuilderTestCase class >> sourceResource [

	^ self resources anyOne current
]

{ #category : 'helpers' }
FamixAbstractJavaCallGraphContextualizerBuilderTestCase >> callStackModel [

	^ self sourceResource callStackModel
]

{ #category : 'helpers' }
FamixAbstractJavaCallGraphContextualizerBuilderTestCase >> graph [

	^ self sourceResource graph
]

{ #category : 'helpers' }
FamixAbstractJavaCallGraphContextualizerBuilderTestCase >> javaModel [

	^ self sourceResource javaModel
]

{ #category : 'open sources' }
FamixAbstractJavaCallGraphContextualizerBuilderTestCase >> openSources [

	<script: 'self new openSources'>
	self resources anyOne javaSourcesFolder openInOSFileBrowser
]

{ #category : 'running' }
FamixAbstractJavaCallGraphContextualizerBuilderTestCase >> performTest [

	FamixCallGraphAdditionalProperties newInstanceDuring: [ super performTest ]
]

{ #category : 'helpers' }
FamixAbstractJavaCallGraphContextualizerBuilderTestCase >> sourceResource [
	"I return the instance of the test resource I'm using to build the sources of a java project"

	^ self class sourceResource
]
