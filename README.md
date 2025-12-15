# Famix-CallGraph-Contextualizer

**Inject dynamic execution context into static architectures.**

This project bridges the gap between static analysis and runtime reality. It maps execution traces (derived from `FamixCallStack`) onto static call graphs (`Famix-CallGraphs`), allowing you to visualize not just what *can* happen, but what *actually* happened during a specific scenario.

## Installation

Install the project in your Moose image via Metacello:

```smalltalk
Metacello new
    baseline: 'FamixCallGraphsContextualizer';
    githubUser: 'LeoDefossez' project: 'Famix-CallGraphs-Contextualizer' commitish: 'master' path: 'src';
    load
```

## Workflow & Usage

Contextualization is a three-step process: **Extract, Load, Apply.**

### 1. Extract the Call Stack
You must first generate a trace from the target application. Use the external extractor:
* [JavaCallStackExtractor](https://github.com/moosetechnology/JavaCallStackExtractor) 

### 2. Prepare the Models
You need to load your models and build the static call graph before applying the context.

**Scenario A: Single Static Model**
Use this standard setup when your application is contained in one Moose model.

```smalltalk
"1. Load the models"
staticModel := MooseModel root allModels detect: [ :m | m name = 'MyJavaModel' ].
stackModel := MooseModel root allModels detect: [ :m | m name = 'MyStackModel' ].

"2. Define the Entry Point (e.g., the first method of the stack or a known main method)"
entryPoint := staticModel allMethods detect: [ :m | m name = 'main' ]. 

"3. Build the Static Call Graph"
graph := (FamixJavaCHABuilder entryPoint: entryPoint) build.
```

**Scenario B: Multiple Static Models (Application + Libraries)**
```smalltalk
"1. Load all related models"
appModel := MooseModel root allModels detect: [ :m | m name = 'MyAppModel' ].
libraryModel := MooseModel root allModels detect: [ :m | m name = 'MyLibraryModel' ].
stackModel := MooseModel root allModels detect: [ :m | m name = 'MyStackModel' ].

"2. Configure the Workspace for Inter-Model analysis"
workspace := MooseWorkspace new
                 mainModel: appModel;
                 addLibraryModel: libraryModel.

"3. Build the Graph using the Workspace context"
entryPoint := appModel allMethods detect: [ :m | m name = 'main' ]. 

workspace interModelModeDuring: [
    graph := (FamixJavaCHABuilder entryPoint: entryPoint) build
].
```

### 3. Contextualize the Graph
Apply the stack data to the graph to generate the contextualized path.

```smalltalk
"Returns a collection of mapped nodes enriched with runtime data, and add this data directly on callGraph"
contextualizedPath := CGContextualizer apply: stackModel on: graph.
```

## Documentation

* [User Documentation](resources/documentation/UserDocumentation.md)