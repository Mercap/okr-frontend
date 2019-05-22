Class {
	#name : #ObjectivesWebView,
	#superclass : #WAPainter,
	#instVars : [
		'workingContext',
		'headerView',
		'objectivesTableView'
	],
	#category : #'Objective-Views'
}

{ #category : #'Instance Creation' }
ObjectivesWebView class >> workingWith: aContext [

	^self new initializeWorkingWith: aContext
]

{ #category : #'Initialization views' }
ObjectivesWebView >> initializeHeaderView [
	
	headerView := 'Objetivos'
]

{ #category : #'as yet unclassified' }
ObjectivesWebView >> initializeObjectivesTableView [

objectivesTableView := self componentSupplier tableBuilder
		addColumn: [ :column | 
			column
				titled: 'Descripción';
				rendering: [ :objective | objective description ] ];
		addColumn: [ :column | 
			column
				titled: 'Key Results';
				rendering: [ :objective | self renderKeyResults: (objective at: #'key-results') ] ];
		build.
		
	objectivesTableView changeContentsTo: workingContext objectives
		


]

{ #category : #initialization }
ObjectivesWebView >> initializeWorkingWith: aContext [

	workingContext := aContext.
	self initializeHeaderView.
	self initializeObjectivesTableView
]

{ #category : #rendering }
ObjectivesWebView >> renderContentOn: aCanvas [
	aCanvas
		render: headerView;
		render: objectivesTableView
]

{ #category : #rendering }
ObjectivesWebView >> renderKeyResult: aKeyResult [
	^ aKeyResult description , ' (' , aKeyResult weight asString , ')'
]

{ #category : #rendering }
ObjectivesWebView >> renderKeyResults: aCollection [
	^ (CollectionFormatter separatingWith: ', ')
		format:
			(aCollection collect:
				[ :keyResult | self renderKeyResult: keyResult ])
]
