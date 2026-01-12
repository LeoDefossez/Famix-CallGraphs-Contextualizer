Class {
	#name : 'FamixAbstractCGContextualizerTestResourceWithDependencies',
	#superclass : 'FamixAbstractJavaCGContextualizerBuilderTestResource',
	#instVars : [
		'librariesModels'
	],
	#category : 'Famix-CallGraphs-Contextualizer-Tests-Resources',
	#package : 'Famix-CallGraphs-Contextualizer-Tests',
	#tag : 'Resources'
}

{ #category : 'as yet unclassified' }
FamixAbstractCGContextualizerTestResourceWithDependencies class >> externalSourcesFolders [
	"Return the java folders containing the external sources to parse for those tests"

	| folders |
	folders := (FamixCallGraphContextualizerBridge sources children select: #isDirectory) select: [ :each |
			           each basename beginsWith:
				           ((self name withoutPrefix: 'CGContextualizer') withoutSuffix: 'Resource') uncapitalized
				           , 'ExternalDependencies' ].

	folders ifEmpty: [ self error: 'No external dependencies found' ].

	^ folders
]

{ #category : 'as yet unclassified' }
FamixAbstractCGContextualizerTestResourceWithDependencies class >> javaExternalSourcesFolders [
	"Return the java folder containing the sources to parse for those tests"

	| folders |
	folders := self externalSourcesFolders collect: [ :each | each / 'src' ].

	folders do: [ :each | each ifAbsent: [ self error: 'Folder does not exists ' , folders pathString ] ].

	^ folders
]

{ #category : 'accessing' }
FamixAbstractCGContextualizerTestResourceWithDependencies >> generateGraph [

	graph := FamixJavaCHABuilder
		         buildFrom: self javaMainModel
		         withDependencies: self librariesModels
		         forEntry: self entryPoints first
]

{ #category : 'accessing' }
FamixAbstractCGContextualizerTestResourceWithDependencies >> importModels [

	super importModels.
	librariesModels := self javaExternalSourcesFolders collect: [ :each |
		                   (FamixJavaFoldersImporter importFolders: { self javaSourcesFolder }) anyOne ]
]

{ #category : 'accessing' }
FamixAbstractCGContextualizerTestResourceWithDependencies >> javaExternalSourcesFolders [

	^ self class javaExternalSourcesFolders
]

{ #category : 'accessing' }
FamixAbstractCGContextualizerTestResourceWithDependencies >> librariesModels [

	^ librariesModels
]

{ #category : 'accessing' }
FamixAbstractCGContextualizerTestResourceWithDependencies >> tearDown [

	librariesModels := nil.
	super tearDown
]
