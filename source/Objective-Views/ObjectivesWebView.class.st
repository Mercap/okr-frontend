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
				titled: 'Number';
				rendering: [ :number | number ] ];
		addColumn: [ :column | 
			column
				titled: 'Even?';
				rendering: [ :number | number even ] ];
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
