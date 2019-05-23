Class {
	#name : #TeamsWevView,
	#superclass : #WAPainter,
	#instVars : [
		'workingContext',
		'headerView',
		'teamsTableView'
	],
	#category : #'Team-Views'
}

{ #category : #'Instance Creation' }
TeamsWevView class >> workingWith: aContext [

	^ self new initializeWorkingWith: aContext
]

{ #category : #initialization }
TeamsWevView >> initializeHeaderView [

	headerView := 'Grupos'
]

{ #category : #initialization }
TeamsWevView >> initializeTeamsTableView [

	teamsTableView := self componentSupplier tableBuilder
		addColumn: [ :column | 
			column
				titled: 'Nombre';
				rendering: [ :team | team name ]
			];
		addColumn: [ :column | 
			column
				titled: 'Miembros';
				rendering: [ :team | self renderMembers: team members ]
			];
		build.

	teamsTableView changeContentsTo: workingContext members
]

{ #category : #initialization }
TeamsWevView >> initializeWorkingWith: aContext [

	workingContext := aContext.
	self initializeHeaderView.
	self initializeTeamsTableView
]

{ #category : #Rendering }
TeamsWevView >> renderContentOn: aCanvas [

	aCanvas
		render: headerView;
		render: teamsTableView
]

{ #category : #Rendering }
TeamsWevView >> renderMember: aMember [

	^ '<1s> z2s> - <3s>' expandMacrosWith: aMember name with: aMember lastName with: aMember email
]

{ #category : #Rendering }
TeamsWevView >> renderMembers: aMembersCollection [

	^ ( CollectionFormatter separatingWith: ', ' )
		format: ( aMembersCollection collect: [ :member | self renderMember: member ] )
]
