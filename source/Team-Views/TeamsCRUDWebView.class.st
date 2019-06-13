Class {
	#name : #TeamsCRUDWebView,
	#superclass : #WAPainter,
	#instVars : [
		'workingContext',
		'teamView',
		'addMemberButton',
		'membersTableView',
		'membersView',
		'helperContext',
		'buildingObject'
	],
	#category : #'Team-Views'
}

{ #category : #'as yet unclassified' }
TeamsCRUDWebView class >> displayedIn: aContext [ 

	^ self  editionOf: self newTeam displayedIn: aContext 
]

{ #category : #'as yet unclassified' }
TeamsCRUDWebView class >> editionOf: aTeam displayedIn: aContext [ 

	^ self new initializeEditionOf: aTeam displayedIn: aContext 
]

{ #category : #'as yet unclassified' }
TeamsCRUDWebView class >> newTeam [

	^ NeoJSONObject new
		at: #name put: '';
		at: #members put: #();
		yourself
]

{ #category : #initialization }
TeamsCRUDWebView >> initializeEditionOf: aTeam displayedIn: aContext [

	buildingObject := aTeam.
	workingContext := aContext.
	self initializeViews
]

{ #category : #initialization }
TeamsCRUDWebView >> initializeMembersView [

	membersView := self componentSupplier
		multipleSelectionListBoxDisplayingAtOnce: 10
		applying: [ :field |  ].

	membersView
		allowAnyOf: workingContext members;
		chooseAllIn: buildingObject members
]

{ #category : #initialization }
TeamsCRUDWebView >> initializeTeamView [

	teamView := self componentSupplier
		singleLineTextFieldApplying: [ :field | 
			field addClass bootstrap formControl + ( field setPlaceholderTo: #'Ingrese un Equipo' )
				+ ( InputFieldMaxLengthCommand allowingUpTo: 100 )
			].

	teamView changeContentsTo: buildingObject name
]

{ #category : #initialization }
TeamsCRUDWebView >> initializeViews [

	self
		initializeTeamView;
		initializeMembersView
]

{ #category : #initialization }
TeamsCRUDWebView >> jsonObject [

	^ NeoJSONObject new
		at: #name put: teamView contents;
		at: #members put: membersView currentSelection;
		yourself
]

{ #category : #initialization }
TeamsCRUDWebView >> labelViewTitled: aTitle displaying: aView [

	^ BootstrapLabeledWebView
		displaying: aTitle
		applying: [ :label | label addClass bootstrap columnMedium: 3 ]
		boundTo: aView
		applying: [ :view | view addClass bootstrap columnMedium: 9 ]
]

{ #category : #initialization }
TeamsCRUDWebView >> renderContentOn: aCanvas [

	aCanvas
		render:
			( self componentSupplier gridBuilder
				columnsPerRow: 1;
				addContent: ( self labelViewTitled: 'Equipo' displaying: teamView );
				build ).
	aCanvas
		render:
			( self componentSupplier
				fieldSetContaining: membersView
				applying: [  ]
				withLegend: 'Miembros'
				applying: [  ] )
]
