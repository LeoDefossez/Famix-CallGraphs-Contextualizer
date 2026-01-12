Class {
	#name : 'FamixAbstractJavaCGContextualizerBuilderTestResource',
	#superclass : 'TestResource',
	#instVars : [
		'graph',
		'callStackModel',
		'javaMainModel'
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
FamixAbstractJavaCGContextualizerBuilderTestResource >> generateGraph [

	graph := (FamixJavaCHABuilder entryPoints: self entryPoints) build
]

{ #category : 'accessing' }
FamixAbstractJavaCGContextualizerBuilderTestResource >> graph [
	^ graph
]

{ #category : 'accessing' }
FamixAbstractJavaCGContextualizerBuilderTestResource >> importModels [

	javaMainModel := (FamixJavaFoldersImporter importFolders: { self javaSourcesFolder }) anyOne.
	callStackModel := CallStackJsonReader import: self callStackFile
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
FamixAbstractJavaCGContextualizerBuilderTestResource >> setUp [

	super setUp.
	self importModels.
	self generateGraph
]

{ #category : 'accessing' }
FamixAbstractJavaCGContextualizerBuilderTestResource >> tearDown [

	javaMainModel := nil.
	graph := nil.
	callStackModel := nil.
	super tearDown
]
