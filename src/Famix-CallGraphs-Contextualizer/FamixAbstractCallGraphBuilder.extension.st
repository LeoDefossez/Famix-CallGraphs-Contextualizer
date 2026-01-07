Extension { #name : 'FamixAbstractCallGraphBuilder' }

{ #category : '*Famix-CallGraphs-Contextualizer' }
FamixAbstractCallGraphBuilder class >> buildFrom: mainModel withDependencies: librariesModels forEntry: aFamixMethod [

	| workspace |
	workspace := MooseWorkspace new mainModel: mainModel.
	librariesModels do: [ :each | workspace addLibraryModel: each ].

	^ workspace interModelModeDuring: [ (self entryPoint: aFamixMethod) build ]
]
