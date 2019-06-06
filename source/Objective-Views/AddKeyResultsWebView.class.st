Class {
	#name : #AddKeyResultsWebView,
	#superclass : #WAPainter,
	#instVars : [
		'workingContext',
		'descriptionView',
		'weightView'
	],
	#category : #'Objective-Views'
}

{ #category : #'as yet unclassified' }
AddKeyResultsWebView class >> workingWith: aWorkingContext [ 
	
	^self new initializeWorkingWith: aWorkingContext 
]

{ #category : #accessing }
AddKeyResultsWebView >> description [

	^ descriptionView contents
]

{ #category : #'as yet unclassified' }
AddKeyResultsWebView >> initializeDescriptionView [

	descriptionView := self componentSupplier
		multiLineTextFieldApplying: [ :field | 
			field addClass bootstrap formControl
				+ (ComponentAttributeCommand named: #rows with: 5) ]
]

{ #category : #'as yet unclassified' }
AddKeyResultsWebView >> initializeViews [

	self
		initializeDescriptionView;
		initializeWeightView
]

{ #category : #'as yet unclassified' }
AddKeyResultsWebView >> initializeWeightView [
	
	weightView := self componentSupplier decimalNumberFieldApplying: [ :field | ]
]

{ #category : #'as yet unclassified' }
AddKeyResultsWebView >> initializeWorkingWith: aWorkingContext [

	workingContext := aWorkingContext.
	self initializeViews
]

{ #category : #'as yet unclassified' }
AddKeyResultsWebView >> labelViewTitled: aTitle displaying: aView [

	^BootstrapLabeledWebView
		displaying: aTitle
		applying: [:label | label addClass bootstrap columnMedium: 3]
		boundTo: aView
		applying: [:view | view addClass bootstrap columnMedium: 9]
]

{ #category : #rendering }
AddKeyResultsWebView >> renderContentOn: aCanvas [

	aCanvas
		render:
			(self componentSupplier gridBuilder
				columnsPerRow: 1;
				addContent: (self labelViewTitled: 'Descripción' displaying: descriptionView);
				addContent: (self labelViewTitled: 'Peso' displaying: weightView);
				build)
]

{ #category : #accessing }
AddKeyResultsWebView >> weight [

	^ ( ( Float readFrom: weightView contents ) / 100 ) asString
]
