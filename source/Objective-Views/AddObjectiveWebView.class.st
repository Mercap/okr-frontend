Class {
	#name : #AddObjectiveWebView,
	#superclass : #WAPainter,
	#instVars : [
		'workingContext',
		'objectiveView',
		'addKeyResultButton',
		'keyResultsTableView',
		'keyResultsView'
	],
	#category : #'Objective-Views'
}

{ #category : #'Instance Creation' }
AddObjectiveWebView class >> displayedIn: aContext [ 

	^self new initializeDisplayedIn: aContext
]

{ #category : #initialization }
AddObjectiveWebView >> initializeDisplayedIn: aContext [ 

	workingContext := aContext.
	
	self initializeViews
]

{ #category : #'Initialization views' }
AddObjectiveWebView >> initializeKeyResultsView [

	keyResultsView := KeyResultsWebView workingWith: workingContext 
]

{ #category : #'Initialization views' }
AddObjectiveWebView >> initializeObjectiveView [
	objectiveView := self componentSupplier
		singleLineTextFieldApplying: [ :field | 
			field addClass bootstrap formControl
				+ (field setPlaceholderTo: #'Ingrese un objetivo')
				+ (InputFieldMaxLengthCommand allowingUpTo: 100) ]
]

{ #category : #'Initialization views' }
AddObjectiveWebView >> initializeViews [

	self
		initializeObjectiveView;
		initializeKeyResultsView
]

{ #category : #'as yet unclassified' }
AddObjectiveWebView >> jsonObject [

	^ NeoJSONObject new
		at: #description put: objectiveView contents;
		at: #'key-results' put: keyResultsView keyResults;
		yourself
]

{ #category : #rendering }
AddObjectiveWebView >> labelViewTitled: aTitle displaying: aView [

	^BootstrapLabeledWebView
		displaying: aTitle
		applying: [:label | label addClass bootstrap columnMedium: 3]
		boundTo: aView
		applying: [:view | view addClass bootstrap columnMedium: 9]
]

{ #category : #rendering }
AddObjectiveWebView >> renderContentOn: aCanvas [

	aCanvas
		render:
			(self componentSupplier gridBuilder
				columnsPerRow: 1;
				addContent: (self labelViewTitled: 'Objectivo' displaying: objectiveView);
				build).
	aCanvas
		render:
			(self componentSupplier
				fieldSetContaining: keyResultsView
				applying: [  ]
				withLegend: 'Key Results'
				applying: [  ])
]
