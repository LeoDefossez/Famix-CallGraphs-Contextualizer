# Famix-CallGraph-Contextualizer

Provides execution context to Famix-CallGraphs by integrating CallStack from FamixCallStack.

This project acts as a bridge between static and dynamic analysis. It enriches the graph structures from `Famix-CallGraphs` with the runtime information provided by `FamixCallStacks`.

It relies on the following dependencies:
* [Famix-Bridge](https://github.com/moosetechnology/Famix-Bridge)
* [Famix-CallGraphs](https://github.com/jecisc/Famix-CallGraphs)
* [FamixCallStack](https://github.com/LeoDefossez/FamixCallStack)

## Installation

To install the project in your Pharo image execute:

```Smalltalk
Metacello new
    baseline: 'Famix-CallGraph-Contextualizer';
    githubUser: 'LeoDefossez' project: 'Famix-CallGraph-Contextualizer' commitish: 'main' path: 'src';
    load
```
