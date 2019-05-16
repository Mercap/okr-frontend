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

{ #category : #'as yet unclassified' }
DashboardView >> applicationContext [
	^context 
]

{ #category : #initialization }
DashboardView >> initializeWorkingWith: aWorkingContext [ 
	context := aWorkingContext 
]

{ #category : #rendering }
DashboardView >> renderContentOn: aCanvas [
	aCanvas
		render: ('Bienvenido <1s>' expandMacrosWith: context currenUser).
	self renderObjectivesButtonOn: aCanvas
]

{ #category : #rendering }
DashboardView >> renderObjectivesButtonOn: aCanvas [
	"Hay que extraer la vista del boton"

	| objectiveButton |
	objectiveButton := self componentSupplier
		asynchronicButtonLabeled: 'Objetivos'
		applying: [  ].
	objectiveButton onTrigger
		evaluate: [ self applicationContext renderObjectivesView ];
		render: self applicationContext contentView.
		
	"extraer lo de arriba"
	aCanvas render: objectiveButton
]
