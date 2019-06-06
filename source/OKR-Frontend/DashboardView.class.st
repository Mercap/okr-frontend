Class {
	#name : #DashboardView,
	#superclass : #WAPainter,
	#instVars : [
		'context',
		'topMenu',
		'contentView',
		'identifiedContentView'
	],
	#category : #'OKR-Frontend'
}

{ #category : #'instance creation' }
DashboardView class >> workingWith: aWorkingContext [ 
	^self new initializeWorkingWith: aWorkingContext 
]

{ #category : #configuring }
DashboardView >> configureTriggerFor: aComponent toSwitchTo: aWebView [

	aComponent onTrigger
		evaluate: [ self switchContentViewTo: aWebView ];
		render: identifiedContentView
]

{ #category : #views }
DashboardView >> dashboardSummaryView [
	^ DashboardSummaryView workingWith: context
]

{ #category : #initialization }
DashboardView >> initializeIdentifiedContentView [
	identifiedContentView := IdentifiedWebView
		forDivNamed: 'content'
		containing: [ :canvas | canvas render: contentView ]
]

{ #category : #initialization }
DashboardView >> initializeTopMenu [
	
	topMenu := BootstrapNavigationBar fluidBrandedWith: [ :canvas || logo |	
	logo := self componentSupplier
		asynchronicLinkActingAsButtonLabeled: 'Objective Key Results app'
		applying: [:button | button addClass bootstrap navbarBrand].
	self configureTriggerFor: logo toSwitchTo: self dashboardSummaryView.
	 canvas render: logo] 
	containing: 
	[ :canvas |  | logoutButton |

	logoutButton := self componentSupplier
		asynchronicButtonLabeled: 'Logout'
		applying: [ :anchor | anchor addClass bootstrap buttonPrimary + anchor addClass bootstrap navbarButton].
	logoutButton onTrigger
		evaluate: [ context logout ];
		render: context mainContentView.
	self renderTopMenuOptionsOn: canvas.
	canvas div with: [ :logoutCanvas | logoutCanvas div with: [ :divCanvas | divCanvas  render: ('Bienvenido <1s> ' expandMacrosWith: context currenUser) ] applying: [:div | div addClass bootstrap navbarText ] .
		logoutCanvas render: logoutButton  ] applying: [ :div | div addClass bootstrap navbarRight  ]			]
		applying: [ :navigation | navigation addClass bootstrap navbarInverse  + navigation addClass bootstrap navbarStaticTop] 
]

{ #category : #initialization }
DashboardView >> initializeWorkingWith: aWorkingContext [
	context := aWorkingContext.
	self initializeTopMenu.
	self switchContentViewTo: self dashboardSummaryView.
	self initializeIdentifiedContentView
]

{ #category : #views }
DashboardView >> manageObjectivesView [

	^ ObjectivesWebView workingWith: ( ObjectiveContext using: context httpClient )
]

{ #category : #views }
DashboardView >> manageTeamsView [

	^ TeamsWebView workingWith: ( TeamsContext queryUsing: context httpClient )
]

{ #category : #rendering }
DashboardView >> renderContentOn: aCanvas [

	aCanvas render: topMenu.
	aCanvas render: identifiedContentView
]

{ #category : #rendering }
DashboardView >> renderTopMenuOptionsOn: aCanvas [

	| individualObjectives teamObjectives teams |
	
	individualObjectives := self componentSupplier
		asynchronicButtonLabeled: 'Objetivos individuales'
		applying: [ :button | button addClass bootstrap navbarButton].
	self configureTriggerFor: individualObjectives toSwitchTo: self manageObjectivesView.
	teamObjectives := self componentSupplier
		asynchronicButtonLabeled: 'Objetivos grupales'
		applying: [ :button | button addClass bootstrap navbarButton].
	teams  := self componentSupplier
		asynchronicButtonLabeled: 'Equipos'
		applying: [ :button | button addClass bootstrap navbarButton].
		self configureTriggerFor: teams toSwitchTo: self manageTeamsView.
	aCanvas render: individualObjectives.
	aCanvas render: teamObjectives.
	aCanvas render: teams.
]

{ #category : #rendering }
DashboardView >> switchContentViewTo: aContentView [

	contentView := aContentView
]
