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
DashboardView >> objectivesButton [
	| objectivesButton |
	objectivesButton := self componentSupplier
		asynchronicButtonLabeled: 'Objetivos'
		applying: [  ].
	objectivesButton onTrigger
		evaluate: [ self applicationContext renderObjectivesView ];
		render: self applicationContext contentView.
	^ objectivesButton
]

{ #category : #rendering }
DashboardView >> renderContentOn: aCanvas [

	aCanvas render: ( 'Bienvenido <1s>' expandMacrosWith: context currenUser ).
	self
		renderObjectivesButtonOn: aCanvas;
		renderTeamsButtonOn: aCanvas
]

{ #category : #rendering }
DashboardView >> renderObjectivesButtonOn: aCanvas [
		
	aCanvas render: self objectivesButton
]

{ #category : #rendering }
DashboardView >> renderTeamsButtonOn: aCanvas [
		
	aCanvas render: self teamsButton
]

{ #category : #rendering }
DashboardView >> teamsButton [

	| objectivesButton |

	objectivesButton := self componentSupplier asynchronicButtonLabeled: 'Equipos' applying: [  ].
	objectivesButton onTrigger
		evaluate: [ self applicationContext renderTeamsView ];
		render: self applicationContext contentView.
	^ objectivesButton
]
