Class {
	#name : 'FamixAbstractCGContextualizerTestResource',
	#superclass : 'TestResource',
	#instVars : [
		'graph',
		'callStackModel',
		'javaMainModel'
	],
	#category : 'Famix-CallGraphs-Contextualizer-Tests',
	#package : 'Famix-CallGraphs-Contextualizer-Tests'
}

{ #category : 'accessing' }
FamixAbstractCGContextualizerTestResource class >> callStackFile [
	"Return the java file containing the sources to parse for those tests"

	| file |
	file := self sourcesFolder
	        / (((self name withoutPrefix: 'CGContextualizer') withoutSuffix: 'Resource') uncapitalized , '.cs').

	file ifAbsent: [ self error: 'File does not exists ' , file pathString ].

	^ file
]

{ #category : 'accessing' }
FamixAbstractCGContextualizerTestResource class >> javaSourcesFolder [
	"Return the java folder containing the sources to parse for those tests"

	| folder |
	folder := self sourcesFolder / 'src'.

	folder ifAbsent: [ self error: 'Folder does not exists ' , folder pathString ].

	^ folder
]

{ #category : 'accessing' }
FamixAbstractCGContextualizerTestResource class >> sourcesFolder [
	"Return the java folder containing the sources to parse for those tests"

	| folder |
	folder := FamixCallGraphContextualizerBridge sources
	          / ((self name withoutPrefix: 'CGContextualizer') withoutSuffix: 'Resource') uncapitalized.
	
	folder ifAbsent: [ self error: 'Folder does not exists ' , folder pathString ].

	^ folder
]

{ #category : 'accessing' }
FamixAbstractCGContextualizerTestResource >> callStackFile [

	^ self class callStackFile
]

{ #category : 'accessing' }
FamixAbstractCGContextualizerTestResource >> callStackModel [

	^ callStackModel
]

{ #category : 'accessing' }
FamixAbstractCGContextualizerTestResource >> entryPoints [

	^ javaMainModel allMethods select: [ :method | method name = 'main' ]
]

{ #category : 'accessing' }
FamixAbstractCGContextualizerTestResource >> generateGraph [

	graph := (FamixJavaCHABuilder entryPoints: self entryPoints) build
]

{ #category : 'accessing' }
FamixAbstractCGContextualizerTestResource >> graph [
	^ graph
]

{ #category : 'accessing' }
FamixAbstractCGContextualizerTestResource >> importModels [

	javaMainModel := (FamixJavaFoldersImporter importFolders: { self javaSourcesFolder }) anyOne.
	callStackModel := CallStackJsonReader import: self callStackFile
]

{ #category : 'accessing' }
FamixAbstractCGContextualizerTestResource >> javaMainModel [

	^ javaMainModel
]

{ #category : 'accessing' }
FamixAbstractCGContextualizerTestResource >> javaSourcesFolder [
	^ self class javaSourcesFolder
]

{ #category : 'accessing' }
FamixAbstractCGContextualizerTestResource >> setUp [

	super setUp.
	self importModels.
	self generateGraph
]

{ #category : 'accessing' }
FamixAbstractCGContextualizerTestResource >> tearDown [

	javaMainModel := nil.
	graph := nil.
	callStackModel := nil.
	super tearDown
]
