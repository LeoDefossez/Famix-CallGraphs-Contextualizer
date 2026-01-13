Class {
	#name : 'FamixAbstractJavaCGContextualizerBuilderTestResource',
	#superclass : 'TestResource',
	#instVars : [
		'graph',
		'callStackModel',
		'javaMainModel',
		'librariesModels'
	],
	#category : 'Famix-CallGraphs-Contextualizer-Tests-Resources',
	#package : 'Famix-CallGraphs-Contextualizer-Tests',
	#tag : 'Resources'
}

{ #category : 'accessing' }
FamixAbstractJavaCGContextualizerBuilderTestResource class >> callStackFile [
	"Return the java file containing the sources to parse for those tests"

	| file |
	file := self sourcesFolder
	        / (((self name withoutPrefix: 'CGContextualizer') withoutSuffix: 'Resource') uncapitalized , '.cs').

	file ifAbsent: [ self error: 'File does not exists ' , file pathString ].

	^ file
]

{ #category : 'as yet unclassified' }
FamixAbstractJavaCGContextualizerBuilderTestResource class >> externalSourcesFolders [
	"Return the java folders containing the external sources to parse for those tests"

	| folders |
	folders := (FamixCallGraphContextualizerBridge sources children select: #isDirectory) select: [ :each |
			           each basename beginsWith:
				           ((self name withoutPrefix: 'CGContextualizer') withoutSuffix: 'Resource') uncapitalized
				           , 'ExternalDependencies' ].

	^ folders
]

{ #category : 'accessing' }
FamixAbstractJavaCGContextualizerBuilderTestResource class >> javaExternalSourcesFolders [
	"Return the java folder containing the sources to parse for those tests"

	| folders |
	folders := self externalSourcesFolders collect: [ :each | each / 'src' ].

	folders do: [ :each | each ifAbsent: [ self error: 'Folder does not exists ' , each pathString ] ].

	^ folders
]

{ #category : 'accessing' }
FamixAbstractJavaCGContextualizerBuilderTestResource class >> javaSourcesFolder [
	"Return the java folder containing the sources to parse for those tests"

	| folder |
	folder := self sourcesFolder / 'src'.

	folder ifAbsent: [ self error: 'Folder does not exists ' , folder pathString ].

	^ folder
]

{ #category : 'accessing' }
FamixAbstractJavaCGContextualizerBuilderTestResource class >> sourcesFolder [
	"Return the java folder containing the sources to parse for those tests"

	| folder |
	folder := FamixCallGraphContextualizerBridge sources
	          / ((self name withoutPrefix: 'CGContextualizer') withoutSuffix: 'Resource') uncapitalized.
	
	folder ifAbsent: [ self error: 'Folder does not exists ' , folder pathString ].

	^ folder
]

{ #category : 'accessing' }
FamixAbstractJavaCGContextualizerBuilderTestResource >> callStackFile [

	^ self class callStackFile
]

{ #category : 'accessing' }
FamixAbstractJavaCGContextualizerBuilderTestResource >> callStackModel [

	^ callStackModel
]

{ #category : 'accessing' }
FamixAbstractJavaCGContextualizerBuilderTestResource >> entryPoints [

	^ javaMainModel allMethods select: [ :method | method name = 'main' ]
]

{ #category : 'accessing' }
FamixAbstractJavaCGContextualizerBuilderTestResource >> javaExternalSourcesFolders [

	^ self class javaExternalSourcesFolders
]

{ #category : 'accessing' }
FamixAbstractJavaCGContextualizerBuilderTestResource >> javaMainModel [

	^ javaMainModel
]

{ #category : 'accessing' }
FamixAbstractJavaCGContextualizerBuilderTestResource >> javaSourcesFolder [
	^ self class javaSourcesFolder
]

{ #category : 'accessing' }
FamixAbstractJavaCGContextualizerBuilderTestResource >> librariesModels [

	^ librariesModels
]

{ #category : 'accessing' }
FamixAbstractJavaCGContextualizerBuilderTestResource >> setUp [

	super setUp.
	
	javaMainModel := (FamixJavaFoldersImporter importFolders: { self javaSourcesFolder }) anyOne.
	callStackModel := CallStackJsonReader import: self callStackFile.
	librariesModels := FamixJavaFoldersImporter importFolders: self javaExternalSourcesFolders
]

{ #category : 'accessing' }
FamixAbstractJavaCGContextualizerBuilderTestResource >> tearDown [

	javaMainModel := nil.
	graph := nil.
	callStackModel := nil.
	librariesModels := nil.

	super tearDown
]
