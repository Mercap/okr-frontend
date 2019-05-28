Class {
	#name : #TeamsWebView,
	#superclass : #WAPainter,
	#instVars : [
		'workingContext',
		'headerView',
		'teamsTableView'
	],
	#category : #'Team-Views'
}

{ #category : #'Instance Creation' }
TeamsWebView class >> workingWith: aContext [

	^ self new initializeWorkingWith: aContext
]

{ #category : #Rendering }
TeamsWebView >> addButton [

	| addButton |

	addButton := self componentSupplier
		asynchronicButtonLabeled: [ :innerCanvas | 
			innerCanvas
				render: ( BootstrapIconWebView representing: Glyphicons plus );
				space;
				render: #Agregar
			]
		applying: [ :button | button addClass bootstrap buttonDefault + button addClass bootstrap pullRight ].

	addButton onTrigger open: self addTeamDialog.

	^ addButton
]

{ #category : #Rendering }
TeamsWebView >> addTeamDialog [

	| addTeamWebView |

	addTeamWebView := AddTeamWebView displayedIn: workingContext.

	^ self
		dialogTitled: #'Agregar equipo'
		displaying: [ :canvas | canvas render: addTeamWebView ]
		withFooterButtonNamed: #Agregar
		toExecute: [ workingContext addTeam: addTeamWebView jsonObject.
			teamsTableView changeContentsTo: workingContext teams
			]
]

{ #category : #Rendering }
TeamsWebView >> dialogTitled: aTitle displaying: aView withFooterButtonNamed: aButtonName toExecute: anActionBlock [

	^ self
		dialogTitled: aTitle
		displaying: aView
		withFooterButtonNamed: aButtonName
		toExecute: anActionBlock
		applying: [ :document | document addClass bootstrap modalLarge ]
]

{ #category : #Rendering }
TeamsWebView >> dialogTitled: aTitle displaying: aView withFooterButtonNamed: aButtonName toExecute: anActionBlock applying: aComponentCommand [ 

	| dialog footerButton |

	footerButton := self componentSupplier
		asynchronicButtonLabeled: aButtonName
		applying: [ :button | button addClass bootstrap buttonDefault ].

	dialog := IdentifiedWebView
		forFormNamed: #'management-dialog' asString
		containing: [ :canvas | canvas render: aView ]
		applying: [ :identified | identified addClass bootstrap formHorizontal ].

	footerButton onTrigger
		serializeForm: dialog;
		determineBehaviorByEvaluating: [ :response | 
			anActionBlock value.
			response onReturn
				closeLastDialog;
				render: self session applicationContext  contentView ].

	^ self
		dialogTitled: aTitle
		wrapping: dialog
		withFooterContaining: footerButton
applying: aComponentCommand
]

{ #category : #Rendering }
TeamsWebView >> dialogTitled: aTitle wrapping: aDialog withFooterContaining: modalButton applying: aComponentCommand [

	^ self componentSupplier dialogBuilder
		beSelfCleaning;
		dismissableHeaderTitled: aTitle;
		wrapping: aDialog;
		closeButtonLabeled: #Cancelar
			applying: [ :closeButton | closeButton addClass bootstrap buttonLink ];
		addFooterButton: modalButton;
		buildApplying: aComponentCommand
]

{ #category : #initialization }
TeamsWebView >> initializeHeaderView [

	headerView := 'Grupos'
]

{ #category : #initialization }
TeamsWebView >> initializeTeamsTableView [

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

	teamsTableView changeContentsTo: workingContext teams
]

{ #category : #initialization }
TeamsWebView >> initializeWorkingWith: aContext [

	workingContext := aContext.
	self initializeHeaderView.
	self initializeTeamsTableView
]

{ #category : #Rendering }
TeamsWebView >> renderContentOn: aCanvas [

	aCanvas
		render:
			( GenericContainerWebView
				wrapping: [ :canvas | 
					self renderHeaderOn: canvas.
					canvas render: teamsTableView
					]
				applying: [ :container | container addClass bootstrap containerFluid ] )
]

{ #category : #Rendering }
TeamsWebView >> renderHeaderOn: aCanvas [

	aCanvas
		render:
			( GenericContainerWebView
				wrapping: self teamsBreadcumb
				applying:
					[ :container | ( container addClass bootstrap columnMedium: 12 ) + container addClass bootstrap row ] )
]

{ #category : #Rendering }
TeamsWebView >> renderMember: aMember [

	^ '<1s> z2s> - <3s>' expandMacrosWith: aMember name with: aMember lastName with: aMember email
]

{ #category : #Rendering }
TeamsWebView >> renderMembers: aMembersCollection [

	^ ( CollectionFormatter separatingWith: ', ' )
		format: ( aMembersCollection collect: [ :member | self renderMember: member ] )
]

{ #category : #Rendering }
TeamsWebView >> teamsBreadcumb [

	^ HeadingWebView
		displaying: [ :canvas | 
			canvas
				strong: #Equipos;
				render: self addButton
			]
		withLevel: 2
]
