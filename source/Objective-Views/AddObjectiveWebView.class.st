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
AddObjectiveWebView >> renderContentOn: aCanvas [

	aCanvas render: 'implement me'
]
