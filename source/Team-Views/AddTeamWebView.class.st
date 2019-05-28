Class {
	#name : #AddTeamWebView,
	#superclass : #WAPainter,
	#instVars : [
		'workingContext',
		'teamView',
		'addMemberButton',
		'membersTableView',
		'membersView',
		'helperContext'
	],
	#category : #'Team-Views'
}

{ #category : #'as yet unclassified' }
AddTeamWebView class >> displayedIn: aContext [ 

	^ self new initializeDisplayedIn: aContext 
]

{ #category : #initialization }
AddTeamWebView >> initializeDisplayedIn: aContext [

	workingContext := aContext.
	self initializeViews
]

{ #category : #initialization }
AddTeamWebView >> initializeMembersView [

	membersView := self componentSupplier
		multipleSelectionListBoxDisplayingAtOnce: 10
		applying: [ :field |  ].
		
	membersView allowAnyOf: workingContext members
]

{ #category : #initialization }
AddTeamWebView >> initializeTeamView [

	teamView := self componentSupplier
		singleLineTextFieldApplying: [ :field | 
			field addClass bootstrap formControl + ( field setPlaceholderTo: #'Ingrese un Equipo' )
				+ ( InputFieldMaxLengthCommand allowingUpTo: 100 )
			]
]

{ #category : #initialization }
AddTeamWebView >> initializeViews [

	self
		initializeTeamView;
		initializeMembersView
]

{ #category : #initialization }
AddTeamWebView >> jsonObject [

	^ NeoJSONObject new
		at: #name put: teamView contents;
		at: #members put: membersView currentSelection;
		yourself
]

{ #category : #initialization }
AddTeamWebView >> labelViewTitled: aTitle displaying: aView [

	^ BootstrapLabeledWebView
		displaying: aTitle
		applying: [ :label | label addClass bootstrap columnMedium: 3 ]
		boundTo: aView
		applying: [ :view | view addClass bootstrap columnMedium: 9 ]
]

{ #category : #initialization }
AddTeamWebView >> renderContentOn: aCanvas [

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
