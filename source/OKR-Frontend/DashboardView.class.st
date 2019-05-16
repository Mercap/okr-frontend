Class {
	#name : #DashboardView,
	#superclass : #WAPainter,
	#instVars : [
		'context'
	],
	#category : #'OKR-Frontend'
}

{ #category : #'instance creation' }
DashboardView class >> workingWith: aWorkingContext [ 
	^self new initializeWorkingWith: aWorkingContext 
]

{ #category : #initialization }
DashboardView >> initializeWorkingWith: aWorkingContext [ 
	context := aWorkingContext 
]

{ #category : #rendering }
DashboardView >> renderContentOn: aCanvas [
	aCanvas
		render: ('Bienvenido <1s>' expandMacrosWith: context currenUser)
]
