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

{ #category : #Configuring }
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

{ #category : #Configuring }
TeamsWebView >> addTeamDialog [

	| addTeamWebView |

	addTeamWebView := TeamsCRUDWebView displayedIn: workingContext.

	^ self
		dialogTitled: #'Agregar equipo'
		displaying: [ :canvas | canvas render: addTeamWebView ]
		withFooterButtonNamed: #Agregar
		toExecute: [ workingContext addTeam: addTeamWebView jsonObject.
			teamsTableView changeContentsTo: workingContext teams
			]
]

{ #category : #Configuring }
TeamsWebView >> deleteButtonFor: aTeam [

	| deleteButton |

	deleteButton := self componentSupplier
		asynchronicButtonLabeled: [ :innerCanvas | innerCanvas render: ( BootstrapIconWebView representing: Glyphicons minus ) ]
		applying: [ :button | 
			button addClass bootstrap button + button addClass bootstrap buttonSmall
				+ button addClass bootstrap buttonDanger
			].

	deleteButton onTrigger open: (self removeTeamDialogOf: aTeam ).

	^ deleteButton
]

{ #category : #Configuring }
TeamsWebView >> dialogTitled: aTitle displaying: aView withFooterButtonNamed: aButtonName toExecute: anActionBlock [

	^ self
		dialogTitled: aTitle
		displaying: aView
		withFooterButtonNamed: aButtonName
		toExecute: anActionBlock
		applying: [ :document | document addClass bootstrap modalLarge ]
]

{ #category : #Configuring }
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
]


{ #category : #Configuring }
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

{ #category : #Configuring }
TeamsWebView >> editButtonFor: aTeam [

	| editBUtton |

	editBUtton := self componentSupplier
		asynchronicButtonLabeled: [ :innerCanvas | 
			innerCanvas
				render: ( BootstrapIconWebView representing: Glyphicons pencil  )
			]
		applying: [ :button | button addClass bootstrap button + button addClass bootstrap buttonSmall + button addClass bootstrap buttonWarning  ].

	editBUtton onTrigger open: (self editTeamDialogFor: aTeam).

	^ editBUtton
]

{ #category : #Configuring }
TeamsWebView >> editTeamDialogFor: aTeam [

	| editTeamWebView |

	editTeamWebView := TeamsCRUDWebView editionOf: aTeam displayedIn: workingContext.

	^ self
		dialogTitled: #'Modificar equipo'
		displaying: [ :canvas | canvas render: editTeamWebView ]
		withFooterButtonNamed: #Modificar
		toExecute: [ workingContext updateTeam: editTeamWebView jsonObject.
			teamsTableView changeContentsTo: workingContext teams
			]
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
		addColumn: [ :column | column rendering: [ :team | self editButtonFor: team ] ];
		addColumn: [ :column | column rendering: [ :team | self deleteButtonFor: team ] ];
		build.

	teamsTableView changeContentsTo: workingContext teams
]

{ #category : #initialization }
TeamsWebView >> initializeWorkingWith: aContext [

	workingContext := aContext.
	self initializeHeaderView.
	self initializeTeamsTableView
]

{ #category : #Configuring }
TeamsWebView >> removeTeamDialogOf: aTeam [

	^ self
		dialogTitled: ( #'Desea borrar el equipo <1s>' expandMacrosWith: aTeam name )
		displaying: [ :canvas |  ]
		withFooterButtonNamed: #Aceptar
		toExecute: [ workingContext removeTeam: aTeam.
			teamsTableView changeContentsTo: workingContext teams
			]
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

	^ '<1s> <2s> - <3s>' expandMacrosWith: aMember name with: aMember lastName with: aMember email
]

{ #category : #Rendering }
TeamsWebView >> renderMembers: aMembersCollection [

	^ ( CollectionFormatter separatingWith: ', ' )
		format: ( aMembersCollection collect: [ :member | self renderMember: member ] )
]

{ #category : #Configuring }
TeamsWebView >> teamsBreadcumb [

	^ HeadingWebView
		displaying: [ :canvas | 
			canvas
				strong: #Equipos;
				render: self addButton
			]
		withLevel: 2
]
