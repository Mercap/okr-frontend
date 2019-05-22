Class {
	#name : #AddObjectiveWebView,
	#superclass : #WAPainter,
	#instVars : [
		'workingContext',
		'objectiveView'
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
AddObjectiveWebView >> initializeViews [

	objectiveView := self componentSupplier
		singleLineTextFieldApplying: [ :field | 
			field addClass bootstrap formControl
				+ (field setPlaceholderTo: #'Ingrese un objetivo')
				+ (InputFieldMaxLengthCommand allowingUpTo: 100) ]
]

{ #category : #rendering }
AddObjectiveWebView >> labelViewTitled: aTitle displaying: aView [

	^BootstrapLabeledWebView
		displaying: aTitle
		applying: [:label | label addClass bootstrap columnMedium: 4]
		boundTo: aView
		applying: [:view | view addClass bootstrap columnMedium: 8]
]

{ #category : #rendering }
AddObjectiveWebView >> renderContentOn: aCanvas [

	aCanvas
		render:
			(self componentSupplier gridBuilder
				columnsPerRow: 2;
				addContent:
					(self labelViewTitled: #Objectivo displaying: objectiveView);
				build)
]
