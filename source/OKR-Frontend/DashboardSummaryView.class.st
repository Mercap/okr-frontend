Class {
	#name : #DashboardSummaryView,
	#superclass : #WAPainter,
	#instVars : [
		'context'
	],
	#category : #'OKR-Frontend'
}

{ #category : #'instance creation' }
DashboardSummaryView class >> workingWith: aWorkingContext [
	^ self new initializeWorkingWith: aWorkingContext
]

{ #category : #initialization }
DashboardSummaryView >> initializeWorkingWith: aWorkingContext [
	context := aWorkingContext
]

{ #category : #initialization }
DashboardSummaryView >> renderContentOn: aCanvas [
	aCanvas render: '[Aca va el Resumen]'
]
